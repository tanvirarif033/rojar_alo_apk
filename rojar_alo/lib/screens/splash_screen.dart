import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showMoon = false;
  bool showKids = false;
  bool showLogoGroup = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => showMoon = true);
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() => showKids = true);
    });

    Future.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      setState(() => showLogoGroup = true);
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /// 🔹 Responsive sizes
    final double moonSize = size.width * 0.22;
    final double kidsWidth = size.width * 0.7;
    final double logoSize = size.width * 0.5;

    /// 🔹 Responsive positions (NO OVERLAP)
    final double moonTop = size.height * 0.08;
    final double kidsTop = size.height * 0.26;        // kids in middle
    final double logoGroupTop = size.height * 0.62;   // logo BELOW kids

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// 🌄 BACKGROUND
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg_sp.png',
                fit: BoxFit.cover,
              ),
            ),

            /// 🌙 MOON (LEFT ➜ RIGHT)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              top: showMoon ? moonTop : -moonSize,
              left: showMoon ? size.width * 0.18 : -moonSize,
              child: Image.asset(
                'assets/images/sp_2.png',
                width: moonSize,
              ),
            ),

            /// 👧🧒 KIDS (BOTTOM ➜ UP)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              top: showKids ? kidsTop : size.height,
              left: (size.width - kidsWidth) / 2,
              child: Image.asset(
                'assets/images/sp_1.png',
                width: kidsWidth,
              ),
            ),

            /// 🕌 LOGO + TEXT (ALWAYS BELOW KIDS)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              top: showLogoGroup ? logoGroupTop : size.height,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: showLogoGroup ? 1 : 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// LOGO
                    SizedBox(
                      width: logoSize,
                      height: logoSize,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// TITLE
                    Text(
                      'রোজার আলো',
                      style: TextStyle(
                        fontSize: size.width * 0.085,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 2),

                    /// SUBTITLE
                    Text(
                      'রমজানের আলোয় জীবন গড়ি',
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
