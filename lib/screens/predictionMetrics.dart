import 'package:flutter/material.dart';

class PredictionInfoScreen extends StatelessWidget {
  const PredictionInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Prevents default back button
        flexibleSpace: Container(
          color: const Color.fromRGBO(71, 107, 21, 1), // Adjusted the opacity value
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                const Text(
                  "Prediction Value Info",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(192, 214, 169,100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  padding: const EdgeInsets.only(left: 16,right: 16, bottom: 5,top: 5),
                  child: const Text(
                    'Our prediction system uses a decision tree to evaluate your sleep quality. Here is what each prediction value means:',
                    style: TextStyle(fontSize: 18,),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BulletPoint(
                        color: Colors.green,
                        text:
                        'Prediction Value = 1\nVery Good Sleep Quality: Your sleep is of excellent quality.',
                      ),
                      const SizedBox(height: 10),
                      BulletPoint(
                        color: Colors.lightGreen,
                        text:
                        'Prediction Value = 2\nFairly Good Sleep Quality: Your sleep is generally good but there is some room for improvement.',
                      ),
                      const SizedBox(height: 10),
                      BulletPoint(
                        color: Colors.orange,
                        text:
                        'Prediction Value = 3\nFairly Bad Sleep Quality: Your sleep is not very good, and several factors might need to be addressed.',
                      ),
                      const SizedBox(height: 10),
                      BulletPoint(
                        color: Colors.red,
                        text:
                        'Prediction Value = 4\nVery Bad Sleep Quality: Your sleep quality is poor, and significant changes are needed to improve it.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Based on your sleep data, our decision tree analysis pinpoints where your sleep quality is affected. We provide personalized suggestions to help you achieve better sleep.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final Color color;
  final String text;

  BulletPoint({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
