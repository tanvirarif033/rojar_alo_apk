import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "গোপনীয়তা নীতি",
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
                color: Colors.white, // 👈 AboutScreen-এর মতো
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
                children: const [
                  /// ================= TITLE =================
                  Text(
                    "গোপনীয়তা নীতি",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  Text(
                    "রোজার আলো অ্যাপটি ব্যবহারকারীদের ব্যক্তিগত "
                        "গোপনীয়তাকে সর্বোচ্চ গুরুত্ব দিয়ে থাকে। "
                        "এই নীতিতে ব্যাখ্যা করা হয়েছে আমরা কীভাবে "
                        "তথ্য সংগ্রহ, ব্যবহার ও সুরক্ষা করি।",
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),

                  SizedBox(height: 20),

                  /// ================= DATA COLLECTION =================
                  Text(
                    "তথ্য সংগ্রহ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "রোজার আলো অ্যাপ কোনো ব্যক্তিগত তথ্য যেমন— "
                        "নাম, ফোন নম্বর বা ইমেইল সংগ্রহ করে না। "
                        "কেবলমাত্র কিবলা নির্দেশনা ও নামাজ সম্পর্কিত "
                        "সেবা প্রদানের জন্য প্রয়োজনীয় অনুমতি "
                        "(যেমন: লোকেশন) ব্যবহার করা হতে পারে।",
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),

                  SizedBox(height: 20),

                  /// ================= DATA USAGE =================
                  Text(
                    "তথ্যের ব্যবহার",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "সংগৃহীত তথ্য শুধুমাত্র অ্যাপের ফিচার "
                        "সঠিকভাবে কাজ করানোর জন্য ব্যবহার করা হয়। "
                        "কোনো অবস্থাতেই ব্যবহারকারীর তথ্য "
                        "তৃতীয় পক্ষের সাথে শেয়ার বা বিক্রি করা হয় না।",
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),

                  SizedBox(height: 20),

                  /// ================= PERMISSIONS =================
                  Text(
                    "অনুমতি (Permissions)",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "এই অ্যাপটি কিবলা নির্দেশনার জন্য "
                        "ডিভাইসের লোকেশন অনুমতি চাইতে পারে। "
                        "এই অনুমতি সম্পূর্ণভাবে ব্যবহারকারীর "
                        "নিয়ন্ত্রণে থাকে।",
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),

                  SizedBox(height: 20),

                  /// ================= SECURITY =================
                  Text(
                    "তথ্যের নিরাপত্তা",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "আমরা ব্যবহারকারীর তথ্যের নিরাপত্তা নিশ্চিত করতে "
                        "যথাসম্ভব উপযুক্ত ব্যবস্থা গ্রহণ করি। "
                        "তবে ইন্টারনেটের মাধ্যমে তথ্য আদান-প্রদান "
                        "সম্পূর্ণ নিরাপদ— এমন নিশ্চয়তা দেওয়া সম্ভব নয়।",
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),

                  SizedBox(height: 24),

                  /// ================= FOOTER =================
                  Center(
                    child: Column(
                      children: [
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
                          "আপনার বিশ্বাসই আমাদের দায়িত্ব",
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
}
