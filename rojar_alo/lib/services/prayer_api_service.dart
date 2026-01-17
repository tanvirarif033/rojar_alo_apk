import 'dart:convert';
import 'package:http/http.dart' as http;

class PrayerApiService {
  static const String _url =
      "https://api.aladhan.com/v1/timingsByCity?city=Dhaka&country=Bangladesh&method=1";

  static Future<Map<String, dynamic>> fetchPrayerTimes() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception("Prayer time load failed");
    }
  }
}
