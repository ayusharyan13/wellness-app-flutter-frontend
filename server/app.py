from flask import Flask, request, jsonify
import joblib
import pathlib
import textwrap
import numpy as np

import google.generativeai as genai
from sklearn.tree import _tree

def to_markdown(text):
  text = text.replace('•', '  *')
  return textwrap.indent(text, '> ', predicate=lambda _: True)

features = ['hours_slept', 'conversation_duration', 'dark_duration', 'Noise_duration', 'Silence_duration', 'Voice_duration', 'lock_duration', 'charge_duration', 'Running_duration', 'Stationary_duration', 'Walking_duration'] 
def extract_detailed_decision_paths(tree, feature_names, X):
    tree_ = tree.tree_
    feature_name = [
        feature_names[i] if i != _tree.TREE_UNDEFINED else "undefined!"
        for i in tree_.feature
    ]

    paths = []

    def recurse(node, path, depth):
        if tree_.feature[node] != _tree.TREE_UNDEFINED:
            name = feature_name[node]
            threshold = tree_.threshold[node]
            path_left = f"{name} <= {threshold:.2f}"
            path_right = f"{name} > {threshold:.2f}"
            recurse(tree_.children_left[node], path + [path_left], depth + 1)
            recurse(tree_.children_right[node], path + [path_right], depth + 1)
        else:
            paths.append(path)

    for sample_id in range(X.shape[0]):
        node_indicator = tree.decision_path(X[sample_id].reshape(1, -1))
        leaf_id = tree.apply(X[sample_id].reshape(1, -1))
        path = []
        for node_id in node_indicator.indices[node_indicator.indptr[0]:node_indicator.indptr[1]]:
            if leaf_id[0] == node_id:
                continue
            threshold_sign = "<=" if X[sample_id, tree_.feature[node_id]] <= tree_.threshold[node_id] else ">"
            path.append(f"{feature_names[tree_.feature[node_id]]} {threshold_sign} {tree_.threshold[node_id]:.2f}")
        paths.append(path)

    return paths

def format_decision_path(decision_path):
    formatted_path = []
    for condition in decision_path:
        # Convert conditions to human-readable format
        formatted_condition = condition.replace('_', ' ').capitalize()
        formatted_path.append(formatted_condition)
    return ' -> '.join(formatted_path)

# Function to generate personalized suggestions using GPT
def generate_suggestions(formatted_path, forecast):
    forecast_str = ["Very good sleep quality", "Fairly good sleep quality", "Fairly bad sleep quality", "Very bad sleep quality"][forecast - 1]
    prompt = f"""
    We used a decision tree to forecast the sleep quality of a person based on their past behavior. The resulting decision path is the following:
    Decision path from the root to the decision leaf: {" ".join(formatted_path)}
    The resulting sleep forecast is: {forecast_str}
    Considering the decision path and the decision tree prediction, please provide personalized natural language suggestions for the person to improve sleep quality.
    """

    response = gemini.generate_content(prompt)

    return to_markdown(response.text)

def predict_sleep(user_data):    # Prepare input features for prediction

    input_features = [user_data]
    # Make prediction using the loaded model
    prediction = model.predict(input_features)

    # Convert prediction to a human-readable format
    prediction_str = prediction[0]  # Assuming the prediction is a single value
    
    return prediction_str
    return response.text

genai.configure(api_key="AIzaSyCNE4SQ5JtJ6q3Nue4-gcdGH8U1ksAbFgE")
gemini = genai.GenerativeModel('gemini-pro')

# changed here 
model = joblib.load('sleepModel.pkl')

app = Flask(__name__)
print("Creating Flask app instance...")

@app.route('/')
def index():
    return 'Server is running!'

@app.route('/predict', methods=['POST'])
def predict():
    # Your prediction logic here
    data = request.get_json()

    # Extract input parameters
    hours_slept = float(data['hoursSleptDuration'])
    conversation_duration = float(data['conversationDuration'])
    dark_duration = float(data['darkDuration'])
    noise_duration = float(data['noiseDuration'])
    silence_duration = float(data['silenceDuration'])
    voice_duration = float(data['voiceDuration'])
    lock_duration = float(data['lockDuration'])
    charge_duration = float(data['chargeDuration'])
    running_duration = float(data['runningDuration'])
    stationary_duration = float(data['stationaryDuration'])
    walking_duration = float(data['walkingDuration'])

    user_data = np.array([hours_slept, conversation_duration, dark_duration, noise_duration, silence_duration, voice_duration, lock_duration, charge_duration, running_duration, stationary_duration, walking_duration])
    # Perform prediction using the loaded model
    prediction = predict_sleep(user_data)
    path = extract_detailed_decision_paths(model, features, np.array([user_data]))[0]
    print(path)
    suggestion = generate_suggestions(path, int(prediction))

    # Return prediction as JSON response
    return { "suggestion": suggestion, "prediction": int(prediction) }



if __name__ == '__main__':
    app.run(debug=True, port=8000)
