import 'package:flutter/material.dart';

class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Guide',
        style: TextStyle(
          fontSize: 24
        ),),
        backgroundColor: const Color.fromRGBO(71, 107, 21,100),

      ),
      body: Container(
        decoration:  const BoxDecoration(
            color: Color.fromRGBO(192, 214, 169,100),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.white,
                          size: 36,

                        ),
                        SizedBox(width: 8), // Add spacing between the icon and text
                        Text(
                          'Understand Your Inputs',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Change text color to white
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 20),
              _buildInputExplanation(
                'Hours Slept',
                'The total number of hours you slept during the night.',
                Icons.access_time,
                Colors.blueAccent,
              ),
              _buildInputExplanation(
                'Conversation Duration',
                'The duration of your conversations in minutes.',
                Icons.chat_bubble_outline,
                Colors.green,
              ),
              _buildInputExplanation(
                'Dark Duration',
                'The total time spent in darkness in minutes.',
                Icons.nightlight_round,
                Colors.deepPurple,
              ),
              _buildInputExplanation(
                'Noise Duration',
                'The duration of noise exposure in minutes.',
                Icons.volume_up,
                Colors.orange,
              ),
              _buildInputExplanation(
                'Silence Duration',
                'The duration of silence in minutes.',
                Icons.volume_off,
                Colors.teal,
              ),
              _buildInputExplanation(
                'Voice Duration',
                'The duration of voice activity in minutes.',
                Icons.record_voice_over,
                Colors.pink,
              ),
              _buildInputExplanation(
                'Lock Duration',
                'The duration your phone was locked in minutes.',
                Icons.lock,
                Colors.brown,
              ),
              _buildInputExplanation(
                'Charge Duration',
                'The duration your phone was charging in minutes.',
                Icons.battery_charging_full,
                Colors.green,
              ),
              _buildInputExplanation(
                'Running Duration',
                'The duration you were running in minutes.',
                Icons.directions_run,
                Colors.red,
              ),
              _buildInputExplanation(
                'Stationary Duration',
                'The duration you were stationary in minutes.',
                Icons.accessibility_new,
                Colors.lightBlue,
              ),
              _buildInputExplanation(
                'Walking Duration',
                'The duration you were walking in minutes.',
                Icons.directions_walk,
                Colors.green,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputExplanation(String title, String description, IconData icon, Color iconColor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5),
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
