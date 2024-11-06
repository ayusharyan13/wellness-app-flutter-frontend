import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SleepPredictionScreen extends StatelessWidget {
  final String prediction;
  final String suggestion;

  const SleepPredictionScreen({super.key, required this.prediction, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Screen'),
      ),
      body: Center(
        child: Container(
          color: const Color.fromRGBO(192, 214, 169,100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Prediction Score: $prediction',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    child: Markdown(
                      data: suggestion,
                      styleSheet: MarkdownStyleSheet(
                        h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        p: const TextStyle(fontSize: 16),
                        a: const TextStyle(color: Color.fromRGBO(92, 214, 169,100)),
                      ),
                    ),
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
