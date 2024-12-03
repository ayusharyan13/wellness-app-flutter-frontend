import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Sqlite/sqliteDBHelper.dart';
import '../constants/urlApi.dart';
import '../features/HomePage/screens/HomePage.dart';
import '../features/Profile/model/user.dart';
import '../features/auth/screens/login.dart';
import '../features/blog/BlogPage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


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
    var signInUrl = UrlApi.urlSignIn;

    try {
      print('Attempting login at URL: $signInUrl');
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

      print('Response code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> loginResponse = jsonDecode(response.body);

        final accessToken = loginResponse['accessToken'];
        final tokenType = loginResponse['tokenType'];
        final userid = loginResponse['userId'];

        if (accessToken == null || tokenType == null) {
          throw Exception('Invalid login response: Missing access token or token type.');
        }

        // Save access token in SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('tokenType', tokenType);
        await prefs.setInt('userId',userid);

        // Fetch user details
        final userResponse = await http.get(
          Uri.parse('https://5294-103-139-191-219.ngrok-free.app/api/auth/user/${loginResponse['username']}'),
          headers: <String, String>{
            'Authorization': '$tokenType $accessToken',
          },
        );

        if (userResponse.statusCode == 200) {
          final Map<String, dynamic> userData = jsonDecode(userResponse.body);

          // Create a User object
          final User user = User(
            id: userData['id'],
            name: userData['name'],
            email: userData['email'],
            username: userData['username'],
            roles: (userData['roles'] as List<dynamic>)
                .map((role) => role['name'].toString())
                .toList(),
          );

          // Clear existing user data from SQLite before saving new data
          await DatabaseHelper.instance.updateUser(user); // Update user in SQLite

          print('User details saved to SQLite: $user');

          // Navigate to the homepage
          Get.to(() => const Homepage());
        } else {
          throw Exception('Failed to fetch user details: ${userResponse.statusCode}');
        }
      } else {
        print('Login failed with status code ${response.statusCode}');
        Get.snackbar('Error', 'Failed to login');
      }
    } catch (e) {
      print("Login error: $e");
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
      clearForm();
    }
  }



  Future<bool> isLoggedIn() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Check if accessToken and tokenType are available in SharedPreferences
      final String? accessToken = prefs.getString('accessToken');
      final String? tokenType = prefs.getString('tokenType');

      if (accessToken != null && tokenType != null) {
        // If both accessToken and tokenType are found, the user is logged in
        print('User is already logged in: Token = $accessToken');
        return true;
      } else {
        // If either of the values is missing, the user is not logged in
        print('User is not logged in.');
        return false;
      }
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }


}
