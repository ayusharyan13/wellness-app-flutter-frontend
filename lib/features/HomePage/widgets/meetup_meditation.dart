import 'package:flutter/material.dart';

class MeetupMeditation extends StatelessWidget {
  final Color containerColor;
  final String imageAsset;
  final String titleText;
  final Color titleTextColor;
  final String descriptionText;
  final Color descriptionTextColor;
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonIconColor;
  final VoidCallback onButtonPressed;
  final IconData buttonIcon;

  const MeetupMeditation({
    super.key,
    required this.containerColor,
    required this.imageAsset,
    required this.titleText,
    required this.titleTextColor,
    required this.descriptionText,
    required this.descriptionTextColor,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonIconColor,
    required this.onButtonPressed,
    required this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: containerColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: TextStyle(
                color: titleTextColor,
                fontSize: 25,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      descriptionText,
                      style: TextStyle(
                        color: descriptionTextColor,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 1), // Space between text and button
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 1
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      child: TextButton(
                        onPressed: onButtonPressed,
                        child: Row(
                          children: [
                            Text(
                              buttonText,
                              style: TextStyle(
                                color: buttonTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              buttonIcon,
                              color: buttonIconColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Image on the right
                Image.asset(
                  imageAsset,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
