// lib/services/prayer_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../data/models/prayer_model.dart';
import '../../../data/models/prayer_times_model.dart';
// import '../models/prayer_times_model.dart';

class PrayerApiService {
  static const String baseUrl = 'https://api.aladhan.com/v1';
  
  Future<PrayerTimesModel> getPrayerTimes({
    required double latitude,
    required double longitude,
    required int method,
    required int madhab,
  }) async {
    // Fix: Correct API endpoint format
    final url = Uri.parse(
      '$baseUrl/timings?latitude=$latitude&longitude=$longitude&method=$method&madhab=$madhab'
    );
    
    print('Request URL: $url');
    
    try {
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['code'] == 200) {
          return PrayerTimesModel.fromJson(jsonData, DateTime.now());
        } else {
          throw Exception('API returned error: ${jsonData['status']}');
        }
      } else {
        throw Exception('Failed to load prayer times: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching prayer times: $e');
    }
  }
  
  // Alternative working endpoint
  Future<PrayerTimesModel> getPrayerTimesAlt({
    required double latitude,
    required double longitude,
    required int method,
    required int madhab,
  }) async {
    // Alternative API format
    final url = Uri.parse(
      'https://api.aladhan.com/v1/timings/${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'
      '?latitude=$latitude&longitude=$longitude&method=$method&madhab=$madhab'
    );
    
    print('Alternative URL: $url');
    
    try {
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['code'] == 200) {
          return PrayerTimesModel.fromJson(jsonData, DateTime.now());
        } else {
          throw Exception('API returned error: ${jsonData['status']}');
        }
      } else {
        throw Exception('Failed to load prayer times: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching prayer times: $e');
    }
  }
}