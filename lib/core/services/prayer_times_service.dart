// // lib/services/prayer_times_service.dart
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../features/auth/data/models/prayer_times_model.dart';
// // import '../models/prayer_times_model.dart';
// import '../utils/constants.dart';

// class PrayerTimesService {
//   Future<PrayerTimesModel> getPrayerTimes({
//     required double latitude,
//     required double longitude,
//     required DateTime date,
//   }) async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//           '${AppConstants.baseUrl}${AppConstants.prayerTimesEndpoint}'
//           '?lat=$latitude&lng=$longitude&date=${date.toIso8601String()}'
//         ),
//       );
      
//       if (response.statusCode == 200) {
//         return PrayerTimesModel.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to load prayer times');
//       }
//     } catch (e) {
//       print('Error fetching prayer times: $e');
//       // Return mock data or cached data
//       return _getMockPrayerTimes(date);
//     }
//   }
  
//   PrayerTimesModel _getMockPrayerTimes(DateTime date) {
//     return PrayerTimesModel(
//       fajr: '5:15 AM',
//       fajrEnd: '6:15 AM',
//       sunrise: '6:30 AM',
//       dhuhr: '12:15 PM',
//       dhuhrEnd: '3:45 PM',
//       asr: '3:45 PM',
//       asrEnd: '6:15 PM',
//       maghrib: '6:15 PM',
//       maghribEnd: '7:45 PM',
//       isha: '7:45 PM',
//       ishaEnd: '5:15 AM',
//       nextDayFajr: '5:15 AM',
//       tahajjudEnd: '5:00 AM',
//       sehri: '5:00 AM',
//       date: date,
//       hijriDate: '6 Ramadan 1447',
//       qiblaDirection: 276.0,
//       middleOfNight: '12:00 AM',
//       lastThirdOfNight: '2:00 AM',
//       currentPrayer: _getCurrentPrayer(),
//       nextPrayer: _getNextPrayer(),
//       timeForCurrentPrayer: '5:15 AM',
//       timeForNextPrayer: '6:30 AM',
//     );
//   }

//   String _getCurrentPrayer() {
//     final now = DateTime.now();
//     final hour = now.hour;
    
//     if (hour >= 5 && hour < 6) return 'Fajr';
//     if (hour >= 6 && hour < 12) return 'Sunrise';
//     if (hour >= 12 && hour < 15) return 'Dhuhr';
//     if (hour >= 15 && hour < 18) return 'Asr';
//     if (hour >= 18 && hour < 19) return 'Maghrib';
//     if (hour >= 19 || hour < 5) return 'Isha';
    
//     return 'Fajr';
//   }

//   String _getNextPrayer() {
//     final now = DateTime.now();
//     final hour = now.hour;
    
//     if (hour >= 0 && hour < 5) return 'Fajr';
//     if (hour >= 5 && hour < 6) return 'Sunrise';
//     if (hour >= 6 && hour < 12) return 'Dhuhr';
//     if (hour >= 12 && hour < 15) return 'Asr';
//     if (hour >= 15 && hour < 18) return 'Maghrib';
//     if (hour >= 18 && hour < 19) return 'Isha';
    
//     return 'Fajr';
//   }
// }