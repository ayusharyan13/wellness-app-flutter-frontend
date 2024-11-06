import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_final/constants/urlApi.dart';
import 'package:sleep_final/screens/userGuideScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/blog/BlogPage.dart';


class LoginController extends GetxController {
  var emailOrUserNameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var isLoading = false.obs;

  @override
  void onClose() {
    emailOrUserNameController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }

  void clearForm() {
    emailOrUserNameController.value.clear();
    passwordController.value.clear();
  }

  Future<void> logInButton() async {
    isLoading.value = true;
    const signInUrl = UrlApi.urlSignIn;

    try {
      final response = await http.post(
        Uri.parse(signInUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'usernameOrEmail': emailOrUserNameController.value.text,
          'password': passwordController.value.text,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final accessToken = responseData['accessToken'];
        final tokenType = responseData['tokenType'];

        // Save accessToken in SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('tokenType', tokenType);

        print('accessToken: $accessToken');
        Get.to(() =>  BlogListScreen());
      } else {
        Get.snackbar('Error', 'Failed to Login');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
      clearForm();
    }
  }

  // Function to check if user is already logged in
  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('accessToken');
  }

  // Function to log out the user
  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('tokenType');
  }
}
