import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_final/controllers/suggestionController.dart';
import 'package:sleep_final/screens/predictionScreen.dart';
import '../controllers/predictionController.dart';

class FormController extends GetxController {
  var hoursSleptController = TextEditingController().obs;
  var conversationDurationController = TextEditingController().obs;
  var darkDurationController = TextEditingController().obs;
  var noiseDurationController = TextEditingController().obs;
  var silenceDurationController = TextEditingController().obs;
  var voiceDurationController = TextEditingController().obs;
  var lockDurationController = TextEditingController().obs;
  var chargeDurationController = TextEditingController().obs;
  var runningDurationController = TextEditingController().obs;
  var stationaryDurationController = TextEditingController().obs;
  var walkingDurationController = TextEditingController().obs;

  // final PredictionController predictionController = Get.put(PredictionController());
  // final SuggestionController suggestionController = Get.put(SuggestionController());

  var isLoading = false.obs;

  final String ngrokUrl = "https://bc8e-103-139-191-219.ngrok-free.app";

  @override
  void onClose() {
    hoursSleptController.value.dispose();
    conversationDurationController.value.dispose();
    darkDurationController.value.dispose();
    noiseDurationController.value.dispose();
    silenceDurationController.value.dispose();
    voiceDurationController.value.dispose();
    lockDurationController.value.dispose();
    chargeDurationController.value.dispose();
    runningDurationController.value.dispose();
    stationaryDurationController.value.dispose();
    walkingDurationController.value.dispose();
    super.onClose();
  }
  void clearForm() {
    hoursSleptController.value.clear();
    conversationDurationController.value.clear();
    darkDurationController.value.clear();
    noiseDurationController.value.clear();
    silenceDurationController.value.clear();
    voiceDurationController.value.clear();
    lockDurationController.value.clear();
    chargeDurationController.value.clear();
    runningDurationController.value.clear();
    stationaryDurationController.value.clear();
    walkingDurationController.value.clear();
  }


  Future<void> submitForm() async {

    isLoading.value = true;
    final url = "$ngrokUrl/predict";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'hoursSleptDuration': hoursSleptController.value.text,
          'conversationDuration': conversationDurationController.value.text,
          'darkDuration': darkDurationController.value.text,
          'noiseDuration': noiseDurationController.value.text,
          'silenceDuration': silenceDurationController.value.text,
          'voiceDuration': voiceDurationController.value.text,
          'lockDuration': lockDurationController.value.text,
          'chargeDuration': chargeDurationController.value.text,
          'runningDuration': runningDurationController.value.text,
          'stationaryDuration': stationaryDurationController.value.text,
          'walkingDuration': walkingDurationController.value.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final prediction = responseData['prediction'];
        final suggestion = responseData['suggestion'];
        // print('Predicted sleep in hours is: $prediction');
        print('suggestions: $suggestion');
        Get.to(() =>
            PredictionScreen(
                prediction: prediction.toString(), suggestion: suggestion));
      } else {
        Get.snackbar('Error', 'Failed to submit form');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
      clearForm();
    }
    }

  }


