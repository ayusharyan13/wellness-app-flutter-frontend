import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/Sqlite/sqliteDBHelper.dart';
import '../../auth/screens/login.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';
 // Assuming you have a DatabaseHelper class for SQLite

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from SQLite
  Future<void> _loadUserData() async {
    try {
      // Assuming you have a method to get the current user from SQLite
      User user = await DatabaseHelper.instance.getUser();

      setState(() {
        name = user.name;
        email = user.email;
        username = user.username;
      });
    } catch (e) {
      print('Error loading user data from SQLite: $e');
    }
  }

  Future<void> _logout(BuildContext context) async {
    // Step 1: Remove data from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken'); // Remove the stored access token
    await prefs.remove('tokenType');   // Remove the stored token type
    await prefs.remove('userId');

    // Step 2: Clear user data from SQLite
    await DatabaseHelper.instance.clearUserTable(); // Clears the users table

    // Step 3: Navigate to the login screen and clear the navigation stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display user avatar
            if (name.isNotEmpty) ...[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.teal,
                  child: Text(
                    name[0].toUpperCase(), // Display the first letter of the name
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Display user details
              Text(
                'Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Email',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                email,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Username',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                username,
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () => _logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ]
            else ...[
              Center(child: CircularProgressIndicator())
            ]
          ],
        ),
      ),
    );
  }
}
