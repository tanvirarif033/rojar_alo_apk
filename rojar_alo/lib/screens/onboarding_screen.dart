import 'dart:async';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> pages = [
    {
      "title": "রোজার গুরুত্ব",
      "desc": "রোজা আত্মশুদ্ধি ও তাকওয়া অর্জনের অন্যতম মাধ্যম।",
      "icon": Icons.mosque,
    },
    {
      "title": "দোয়া ও আমল",
      "desc": "সেহরি, ইফতার ও তারাবির গুরুত্বপূর্ণ দোয়া সমূহ।",
      "icon": Icons.favorite,
    },
    {
      "title": "ফজিলত ও হাদিস",
      "desc": "রমজানের ফজিলত ও সহিহ হাদিস জানতে পারুন।",
      "icon": Icons.menu_book,
    },
  ];

  @override
  void initState() {
    super.initState();

    // 🔹 Auto slide (last page-এ গিয়ে থামবে)
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < pages.length - 1) {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  void _onNextPressed() {
    if (_currentIndex == pages.length - 1) {
      // 🔹 Last page → Dashboard
      _goToDashboard();
    } else {
      // 🔹 Not last page → Next slide
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Skip Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToDashboard,
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // 🔹 PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          scale: _currentIndex == index ? 1 : 0.95,
                          duration: const Duration(milliseconds: 400),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green.shade100,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.25),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Icon(
                              pages[index]["icon"],
                              size: 80,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          pages[index]["title"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          pages[index]["desc"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔹 Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  height: 10,
                  width: _currentIndex == index ? 28 : 10,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.green
                        : Colors.green.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Next / Start Button (FIXED LOGIC)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: _onNextPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  _currentIndex == pages.length - 1
                      ? "শুরু করুন"
                      : "পরবর্তী",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
