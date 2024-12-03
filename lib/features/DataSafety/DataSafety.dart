import 'package:flutter/material.dart';

class DataSafetyScreen extends StatelessWidget {
  const DataSafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Safety'),
        backgroundColor: Color.fromRGBO(71, 107, 21,100), // Adjust the color as needed
      ),
      body: Container(
        decoration:  const BoxDecoration(
          color: Color.fromRGBO(192, 214, 169,30),
        ),
        height: double.infinity,
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Data Safety is Our Priority',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '• We ensure that your data is securely stored and protected.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• We do not share your data with any third parties.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• You can delete your data anytime from the settings.',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '• We comply with all data protection regulations to keep your data safe.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
