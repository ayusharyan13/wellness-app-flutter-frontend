import 'package:flutter/material.dart';

class BlogGrid extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/academic.png',
    'assets/images/sleepBlogImg.png',
    'assets/images/wellnessBlg.png',
    'assets/images/mental.png',
  ];

  final List<String> titles = [
    'Academic Pressure',
    'Sleep Issues',
    'Wellness Blog',
    'Mental Health',
  ];

  final List<String> descriptions = [
    'Tips to Manage',
    'Ways to improve sleep quality.',
    'Articles on overall wellness.',
    'Guides to mental well-being.',
  ];

  BlogGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,  // Allow the Column to shrink-wrap
        children: [
          Flexible(  // Wrap GridView with Flexible and use loose fit
            fit: FlexFit.loose,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),  // Disable scrolling
              shrinkWrap: true,  // Shrink to fit content
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 7.0,
                childAspectRatio: 0.99,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: SizedBox(
                    height: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                          child: Image.asset(
                            imagePaths[index],
                            height: 97,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 9),
                        // Title
                        Text(
                          titles[index],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 1),
                        // Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            descriptions[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
