import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  final String title;
  final String content;

  const ContentScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8F5E9),
              Color(0xFFF1F8F4),
            ],
          ),
        ),

        child: Column(
          children: [
            /// ================= HEADER =================
            Container(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1B5E20),
                    Color(0xFF2E7D32),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= CONTENT =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.95),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.15),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: SelectableText(
                        content,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16.5,
                          height: 1.8,
                          color: Color(0xFF263238),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
