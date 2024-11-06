import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleep_final/features/splashScreen/splashScreen.dart';
import 'package:sleep_final/screens/userGuideScreen.dart';
import 'controllers/loginController.dart';
import 'features/auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen()
    );
  }
}

