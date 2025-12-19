import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About App")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Rojar Alo is an Islamic app for Ramadan."),
      ),
    );
  }
}
