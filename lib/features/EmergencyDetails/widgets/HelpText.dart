import 'package:flutter/material.dart';

class HelpText extends StatelessWidget {
  const HelpText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("If you are experiencing a mental health crisis or need\nimmediate support, "
        "please reach out to our hostel\nauthorities or wellness center. "
        "We are here to help you\n24/7. Your mental well-being is our priority, "
        "and \nwe have trained professionals ready to assist you.",
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),);
  }
}
