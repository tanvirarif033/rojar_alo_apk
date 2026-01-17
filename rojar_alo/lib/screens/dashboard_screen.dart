import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../data/content_data.dart';
import 'content_screen.dart';
import 'qibla_screen.dart';
import 'zikir_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'privacy_screen.dart';
import 'prayer_time_widget.dart'; // ✅ already added

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const QiblaScreen(),
    const HomeGrid(), //
    const ZikirScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        elevation: 0,
        centerTitle: true,


        leadingWidth: 56,

        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
            const Text(
              "রোজার আলো",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),



      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            /// ================= DRAWER HEADER =================
            DrawerHeader(
              padding: EdgeInsets.zero, // default padding remove
              decoration: BoxDecoration(
                color: Colors.green.shade800,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // tight layout
                  children: [
                    /// 🕌 APP LOGO (VISUALLY BIG)
                    Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                    ),


                    const SizedBox(height: 8), // controlled small gap

                    /// 📛 APP NAME
                    const Text(
                      "রোজার আলো",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ================= MENU ITEMS =================
            _drawerItem(
              context,
              icon: Icons.info_outline,
              title: "About App",
              page: const AboutScreen(),
            ),
            _drawerItem(
              context,
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              page: const PrivacyScreen(),
            ),
            _drawerItem(
              context,
              icon: Icons.contact_mail_outlined,
              title: "Contact Us",
              page: const ContactScreen(),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          // 🔹 Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/islamic_bg3.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔹 PAGE CONTENT
          _pages[_currentIndex],
        ],
      ),

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
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _drawerItem(BuildContext context,
      {required IconData icon,
        required String title,
        required Widget page}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green.shade700),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}

// ===================================================
// 🕌 HOME GRID (MODIFIED ONLY THIS PART)
// 👉 ONLY PRAYER TIME API SHOWS HERE
// ===================================================

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),

            /// 🕋 PRAYER TIME (TOP)
            const PrayerTimeWidget(),

            const SizedBox(height: 20),

            /// 🔳 CONTENT GRID
            GridView.builder(
              itemCount: contents.length,
              shrinkWrap: true, // ✅ IMPORTANT for SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final color =
                _cardColors[index % _cardColors.length];

                return InkWell(
                  borderRadius: BorderRadius.circular(18),
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: color.withOpacity(0.45),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 58,
                          width: 58,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.18),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _icons[index % _icons.length],
                            size: 30,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            contents[index]['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 🎨 CARD COLORS (UNCHANGED – kept for safety)
final List<Color> _cardColors = [
  Colors.green,
  Colors.orange,
  Colors.blue,
  Colors.purple,
  Colors.teal,
  Colors.redAccent,
  Colors.indigo,
  Colors.brown,
];

// 🕌 ICONS (UNCHANGED – kept for safety)
final List<IconData> _icons = [
  Icons.mosque,
  Icons.wb_sunny_outlined,
  Icons.nightlight_round,
  Icons.access_time,
  Icons.volunteer_activism,
  Icons.auto_awesome_outlined,
  Icons.cancel_outlined,
  Icons.menu_book,
];
