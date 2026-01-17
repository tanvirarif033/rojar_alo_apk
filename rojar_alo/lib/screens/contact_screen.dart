import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "যোগাযোগ করুন",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      /// ✅ FULL SCREEN BACKGROUND FIX
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/islamic_bg3.png"),
              fit: BoxFit.cover, // 👈 FULL COVER GUARANTEED
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600, // tablet friendly
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ================= HEADER =================
                    Center(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.contact_mail_outlined,
                            size: 48,
                            color: Colors.green,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "আমাদের সাথে যোগাযোগ করুন",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "আপনার মতামত ও পরামর্শ আমাদের জন্য গুরুত্বপূর্ণ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// ================= CONTACT INFO =================
                    _contactItem(
                      icon: Icons.email_outlined,
                      title: "ইমেইল",
                      value: "support@rojaralo.com",
                    ),
                    _contactItem(
                      icon: Icons.phone_outlined,
                      title: "ফোন",
                      value: "+880 1XXXXXXXXX",
                    ),
                    _contactItem(
                      icon: Icons.language_outlined,
                      title: "ওয়েবসাইট",
                      value: "www.rojaralo.com",
                    ),
                    _contactItem(
                      icon: Icons.location_on_outlined,
                      title: "ঠিকানা",
                      value: "বাংলাদেশ",
                    ),

                    const SizedBox(height: 24),

                    /// ================= ADS APOLOGY =================
                    const Text(
                      "বিজ্ঞাপন সংক্রান্ত দুঃখ প্রকাশ",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "রোজার আলো অ্যাপটি সম্পূর্ণ বিনামূল্যে ইসলামিক সেবা "
                          "প্রদানের উদ্দেশ্যে তৈরি করা হয়েছে। অ্যাপ পরিচালনা ও "
                          "উন্নয়ন খরচ বহনের জন্য সীমিত আকারে Google বিজ্ঞাপন "
                          "দেখানো হতে পারে।\n\n"
                          "ইবাদতের সময় বিজ্ঞাপন বিরক্তিকর মনে হলে আমরা আন্তরিকভাবে "
                          "দুঃখিত। ইনশাআল্লাহ ভবিষ্যতে বিজ্ঞাপন আরও কমানোর চেষ্টা করা হবে।\n\n"
                          "আল্লাহ আপনাদের উত্তম প্রতিদান দান করুন।",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                      ),
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
                            "আপনার আস্থা আমাদের অনুপ্রেরণা",
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
          ),
        ),
      ),
    );
  }

  /// ================= CONTACT ITEM =================
  Widget _contactItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green.shade800, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
