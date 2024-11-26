import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class BookingFormController extends GetxController {
  var serviceTypeController = TextEditingController().obs;
  var slotStartTimeController = TextEditingController().obs;
  var slotEndTimeController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var consultantController = TextEditingController().obs;



  var isLoading = false.obs;

  final String ngrokUrl = "https://bc8e-103-139-191-219.ngrok-free.app";

  @override
  void onClose() {
    serviceTypeController.value.dispose();
    slotStartTimeController.value.dispose();
    slotEndTimeController.value.dispose();
    phoneNumberController.value.dispose();
    consultantController.value.dispose();

    super.onClose();
  }
  void clearForm() {
    consultantController.value.clear();
    slotStartTimeController.value.clear();
    slotEndTimeController.value.clear();
    phoneNumberController.value.clear();
    consultantController.value.clear();
  }

/*
  Future<void> submitForm() async {

    isLoading.value = true;
    final url = "$ngrokUrl/predict";    // make changes here for hitting api

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
            SleepPredictionScreen(
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
*/
}


