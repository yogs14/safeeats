// file: lib/screens/result_screen.dart
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String extractedText;

  const ResultScreen({super.key, required this.extractedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extraction Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Extracted Text:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                extractedText.isEmpty
                    ? "No text found."
                    : extractedText,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement analysis by sending text to backend
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Analyzing... (not implemented yet)')),
                  );
                },
                child: const Text('Analyze Ingredients'),
              )
            ],
          ),
        ),
      ),
    );
  }
}