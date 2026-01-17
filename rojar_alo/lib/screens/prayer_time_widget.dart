import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/prayer_api_service.dart';

class PrayerTimeWidget extends StatefulWidget {
  const PrayerTimeWidget({super.key});

  @override
  State<PrayerTimeWidget> createState() => _PrayerTimeWidgetState();
}

class _PrayerTimeWidgetState extends State<PrayerTimeWidget> {
  late Future<Map<String, dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = PrayerApiService.fetchPrayerTimes();
  }

  /// ⏰ 24h → 12h converter
  String _to12Hour(String time24) {
    final dt = DateFormat("HH:mm").parse(time24);
    return DateFormat("hh:mm a").format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentTime = DateFormat('hh:mm a').format(now);
    final currentDate = DateFormat('dd MMMM yyyy').format(now);

    return FutureBuilder<Map<String, dynamic>>(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: LinearProgressIndicator(),
          );
        }

        final timings = snapshot.data!['timings'];
        final hijri = snapshot.data!['date']['hijri'];
        final hijriDate =
            "${hijri['day']} ${hijri['month']['en']} ${hijri['year']} হিজরি";

        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              /// 🕒 Current Time
              Text(
                "🕒 বর্তমান সময়: $currentTime",
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 4),

              /// 📅 Date
              Text(
                "📅 আজকের তারিখ: $currentDate",
                style:
                const TextStyle(fontSize: 13, color: Colors.black54),
              ),

              /// 🌙 Hijri
              Text(
                "🌙 $hijriDate",
                style:
                const TextStyle(fontSize: 13, color: Colors.black54),
              ),

              const SizedBox(height: 12),
              const Divider(),

              /// 🕌 Prayer Times Row (Responsive)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _prayerItem(
                    icon: Icons.wb_twilight,
                    name: "ফজর",
                    time: _to12Hour(timings['Fajr']),
                  ),
                  _prayerItem(
                    icon: Icons.wb_sunny_outlined,
                    name: "যোহর",
                    time: _to12Hour(timings['Dhuhr']),
                  ),
                  _prayerItem(
                    icon: Icons.cloud_outlined,
                    name: "আসর",
                    time: _to12Hour(timings['Asr']),
                  ),
                  _prayerItem(
                    icon: Icons.nightlight_round,
                    name: "মাগরিব",
                    time: _to12Hour(timings['Maghrib']),
                  ),
                  _prayerItem(
                    icon: Icons.bedtime_outlined,
                    name: "ইশা",
                    time: _to12Hour(timings['Isha']),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// 🔹 Single Prayer Item (Responsive Column)
  Widget _prayerItem({
    required IconData icon,
    required String name,
    required String time,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 22, color: Colors.green.shade700),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
