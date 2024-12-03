import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String title;
  final Icon icon;

  const ContactCard({
    super.key,
    required this.name,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22.5),
            color: const Color(0xFFE3E9F7),
          ),
          child: Center(
            child: icon, // Display the passed icon
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
