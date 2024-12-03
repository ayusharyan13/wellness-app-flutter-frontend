import 'package:flutter/material.dart';

class EmergencyButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  const EmergencyButton({
    super.key,
    required this.icon,
    required this.text,
    this.height = 48.0,
    this.backgroundColor = const Color(0xFFE3E9F7),
    this.textColor = const Color(0xFF192838),
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
