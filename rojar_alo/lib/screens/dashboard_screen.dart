import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../data/content_data.dart';
import 'content_screen.dart';
import 'qibla_screen.dart';
import 'zikir_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'privacy_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Home is center (index 1)
  int _currentIndex = 1;

  final List<Widget> _pages = const [
    QiblaScreen(), // index 0
    HomeGrid(),     // index 1 (HOME)
    ZikirScreen(),  // index 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // 🔹 APP BAR
      appBar: AppBar(
        title: const Text(
          "Rojar Alo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade800,
        elevation: 0,
      ),

      // 🔹 DRAWER (SIDEBAR)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade800,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mosque, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Rojar Alo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            _drawerItem(
              context,
              icon: Icons.info,
              title: "About App",
              page: const AboutScreen(),
            ),
            _drawerItem(
              context,
              icon: Icons.privacy_tip,
              title: "Privacy Policy",
              page: const PrivacyScreen(),
            ),
            _drawerItem(
              context,
              icon: Icons.contact_mail,
              title: "Contact Us",
              page: const ContactScreen(),
            ),
          ],
        ),
      ),

      // 🔹 BODY
      body: _pages[_currentIndex],

      // 🔹 CURVED BOTTOM NAV
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        height: 60,
        backgroundColor: Colors.transparent,
        color: Colors.green.shade700,
        buttonBackgroundColor: Colors.green.shade800,
        animationDuration: const Duration(milliseconds: 400),
        items: const [
          Icon(Icons.explore, color: Colors.white),
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.fingerprint, color: Colors.white),
        ],
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  // 🔹 Drawer item widget
  Widget _drawerItem(BuildContext context,
      {required IconData icon,
        required String title,
        required Widget page}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green.shade700),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}

// 🔹 HOME GRID (Professional Cards)
class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: contents.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.05,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContentScreen(
                    title: contents[index]['title']!,
                    content: contents[index]['content']!,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade700,
                      Colors.green.shade500,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      contents[index]['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
