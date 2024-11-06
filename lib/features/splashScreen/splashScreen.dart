import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:sleep_final/screens/HomePage.dart';
import 'package:sleep_final/screens/userGuideScreen.dart';
import '../../controllers/loginController.dart';
import '../auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(192, 214, 169, 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Somnofy",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Predict Your Sleep Duration",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              Lottie.asset(
                "assets/animation/sleep_animation.json",
                width: double.infinity,
                height: 500,
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: loginController.isLoggedIn(),
                builder: (context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the future
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data == true) {
                    // If the user is logged in, navigate to the home screen
                    Timer(const Duration(seconds: 2), () {
                      Get.to(const Homepage());
                    });
                    return const Text(
                      "Loading User Guide...",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    );
                  } else {
                    // If not logged in, navigate to the login screen
                    Timer(const Duration(seconds: 2), () {
                      Get.to(const Homepage());
                    });
                    return const Text(
                      "Redirecting to Login...",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
