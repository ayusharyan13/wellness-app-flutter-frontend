import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_final/features/auth/login.dart';
import '../constants/urlApi.dart';

class RegisterController extends GetxController {
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var fullNameController = TextEditingController().obs;
  var userNameController = TextEditingController().obs;

  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    confirmPasswordController.value.dispose();
    fullNameController.value.dispose();
    userNameController.value.dispose();

    super.onClose();
  }
  void clearForm() {
    emailController.value.clear();
    passwordController.value.clear();
    confirmPasswordController.value.clear();
    fullNameController.value.clear();
    userNameController.value.clear();

  }


  Future<void> registerButton() async {
    isLoading.value = true;
    const signUpUrl = UrlApi.urlSignUp;

    try {
      final response = await http.post(
        Uri.parse(signUpUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'name': fullNameController.value.text,
          'username': userNameController.value.text,
          'email': emailController.value.text,
          'password': passwordController.value.text
        }),
      );

      if (response.statusCode == 201) {
        // Successful registration
        Get.snackbar('Success', 'User registered successfully');
        Get.to(() => const LoginScreen());
      } else {
        // Add more details in the error message for debugging
        Get.snackbar('Error', 'Failed to register! Response status: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      // Display a detailed error message to help debug
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
      clearForm();
    }
  }

}


