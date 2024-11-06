import 'package:flutter/material.dart';

class WardenList extends StatelessWidget {
  // Sample lists for student data
  final List<String> imagePaths = [
    'assets/images/student1.png',
    'assets/images/student2.png',
    'assets/images/student3.png',
    'assets/images/student4.png',
  ];

  final List<String> names = [
    'Ashish Sharma',
    'Jane Smith',
    'Michael Brown',
    'Emily Johnson',
    'Emily Johnson',
  ];

  final List<String> hostelNames = [
    'BHAGAT SINGH HOSTEL',
    'HOMI BHABHA HOSTEL',
    'APJ ABDUL KALAM HOSTEL',
    'GARGI HOSTEL',
    'KALPANA CHAWLA HOSTEL'
  ];

  final List<String> phoneNumbers = [
    '+1 123 456 7890',
    '+1 234 567 8901',
    '+1 345 678 9012',
    '+1 456 789 0123',
    '+1 456 789 0123',
  ];

  final List<String> emails = [
    'john.doe@example.com',
    'jane.smith@example.com',
    'michael.brown@example.com',
    'emily.johnson@example.com',
    'emily.johnson@example.com',
  ];

  WardenList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Warden List"),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10.0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(imagePaths[index]),
              ),
              title: Text(
                names[index],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hostel: ${hostelNames[index]}'),
                  Text('Phone: ${phoneNumbers[index]}'),
                  Text('Email: ${emails[index]}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


