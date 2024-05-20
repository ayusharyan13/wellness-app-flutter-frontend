import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'Homepage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 7),(){
      Get.to(const HomePage());
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(192, 214, 169,100),
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
                    color: Colors.black
                ),
              ),
              Lottie.asset("assets/animation/sleep_animation.json",
                  width: double.infinity,
                  height: 500),
            ],
          ),
        ),
      ),
    );
  }
}



