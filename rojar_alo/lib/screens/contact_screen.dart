import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Us")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Email: support@rojaralo.com"),
      ),
    );
  }
}
