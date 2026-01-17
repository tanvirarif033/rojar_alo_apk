import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "অ্যাপ সম্পর্কে",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          /// 🌙 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/islamic_bg3.png",
              fit: BoxFit.cover,
            ),
          ),

          /// ================= CONTENT =================
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, // text readable
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ================= APP NAME =================
                  Center(
                    child: Column(
                      children: const [
                        Text(
                          "রোজার আলো",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "একটি ইসলামিক রমজান সহায়ক অ্যাপ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// ================= ABOUT =================
                  const Text(
                    "রোজার আলো সম্পর্কে",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "রোজার আলো একটি পূর্ণাঙ্গ ইসলামিক অ্যাপ, যা বিশেষভাবে "
                        "রমজান মাসে মুসলিম ভাই ও বোনদের দৈনন্দিন ইবাদত সহজ ও সঠিকভাবে "
                        "আদায় করতে সহায়তা করার জন্য তৈরি করা হয়েছে।",
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),

                  const SizedBox(height: 20),

                  /// ================= FEATURES =================
                  const Text(
                    "এই অ্যাপে যা যা রয়েছে",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  _featureItem("✔ সেহরি ও ইফতারের সময়সূচি"),
                  _featureItem("✔ পাঁচ ওয়াক্ত নামাজের সময়"),
                  _featureItem("✔ কিবলা নির্দেশনা (Qibla Direction)"),
                  _featureItem("✔ তাসবিহ কাউন্টার"),
                  _featureItem("✔ রোজার ফজিলত ও করণীয়"),
                  _featureItem("✔ রোজা ভঙ্গের কারণসমূহ"),
                  _featureItem("✔ গুরুত্বপূর্ণ দোয়া ও যিকির"),
                  _featureItem("✔ ইসলামিক তথ্য ও হাদিস"),

                  const SizedBox(height: 20),

                  /// ================= PURPOSE =================
                  const Text(
                    "অ্যাপটির উদ্দেশ্য",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "এই অ্যাপের মূল উদ্দেশ্য হলো— "
                        "রমজান মাসে প্রতিটি মুসলমানকে সঠিক নিয়মে রোজা রাখা, "
                        "নামাজ আদায় করা এবং আল্লাহর নৈকট্য অর্জনে সহায়তা করা। "
                        "সহজ, সুন্দর ও নির্ভরযোগ্য তথ্যের মাধ্যমে "
                        "ইবাদতের প্রতি আগ্রহ বাড়ানোই আমাদের লক্ষ্য।",
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),

                  const SizedBox(height: 24),

                  /// ================= FOOTER =================
                  Center(
                    child: Column(
                      children: const [
                        Divider(),
                        SizedBox(height: 8),
                        Text(
                          "© ২০২৬ রোজার আলো",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "আল্লাহ আমাদের সবাইকে কবুল করুন",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= FEATURE ITEM =================
  static Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}
