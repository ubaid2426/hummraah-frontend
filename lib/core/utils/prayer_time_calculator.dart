// // lib/utils/prayer_time_calculator.dart
// import 'package:hummraah/features/auth/data/models/prayer_model.dart';
// import 'package:prayers_times/prayers_times.dart';
// import '../../features/auth/data/models/prayer_times_model.dart';

// class PrayerTimeCalculator {
//   // Ensure madhab is valid string
//   static String _parseMadhab(dynamic madhab) {
//     if (madhab == PrayerMadhab.hanafi) return PrayerMadhab.hanafi;
//     if (madhab == PrayerMadhab.shafi) return PrayerMadhab.shafi;

//     if (madhab is String) {
//       if (madhab.toLowerCase() == 'hanafi') return PrayerMadhab.hanafi;
//       if (madhab.toLowerCase() == 'shafi') return PrayerMadhab.shafi;
//     }

//     return PrayerMadhab.hanafi;
//   }

//   static Future<PrayerTimesModel> calculatePrayerTimes({
//     required double latitude,
//     required double longitude,
//     required DateTime date,
//     CalculationMethod method = CalculationMethod.karachi,
//     dynamic madhab = PrayerMadhab.hanafi,
//   }) async {
//     try {
//       final parsedMadhab = _parseMadhab(madhab);

//       Coordinates coordinates = Coordinates(latitude, longitude);

//       PrayerCalculationParameters params = _getCalculationMethod(method);
//       params.madhab = parsedMadhab;

//       final timezoneMinutes = date.timeZoneOffset.inMinutes;
//       final locationName = _getTimezoneName(timezoneMinutes);

//       PrayerTimes prayerTimes = PrayerTimes(
//         coordinates: coordinates,
//         calculationParameters: params,
//         dateTime: date,
//         precision: true,
//         locationName: locationName,
//       );

//       DateTime tomorrow = DateTime(date.year, date.month, date.day + 1);

//       PrayerTimes tomorrowTimes = PrayerTimes(
//         coordinates: coordinates,
//         calculationParameters: params,
//         dateTime: tomorrow,
//         precision: true,
//         locationName: locationName,
//       );

//       SunnahInsights sunnahInsights = SunnahInsights(prayerTimes);
//       double qiblaDirection = Qibla.qibla(coordinates);

//       return PrayerTimesModel(
//         fajr: _formatPrayerTime(prayerTimes.fajrStartTime),
//         fajrEnd: _formatPrayerTime(prayerTimes.fajrEndTime),
//         sunrise: _formatPrayerTime(prayerTimes.sunrise),
//         dhuhr: _formatPrayerTime(prayerTimes.dhuhrStartTime),
//         dhuhrEnd: _formatPrayerTime(prayerTimes.dhuhrEndTime),
//         asr: _formatPrayerTime(prayerTimes.asrStartTime),
//         asrEnd: _formatPrayerTime(prayerTimes.asrEndTime),
//         maghrib: _formatPrayerTime(prayerTimes.maghribStartTime),
//         maghribEnd: _formatPrayerTime(prayerTimes.maghribEndTime),
//         isha: _formatPrayerTime(prayerTimes.ishaStartTime),
//         ishaEnd: _formatPrayerTime(prayerTimes.ishaEndTime),
//         nextDayFajr: _formatPrayerTime(tomorrowTimes.fajrStartTime),
//         tahajjudEnd: _formatPrayerTime(prayerTimes.tahajjudEndTime),
//         sehri: _formatPrayerTime(prayerTimes.sehri),
//         date: date,
//         hijriDate: _getHijriDate(date),
//         qiblaDirection: qiblaDirection,
//         middleOfNight: _formatPrayerTime(sunnahInsights.middleOfTheNight),
//         lastThirdOfNight: _formatPrayerTime(sunnahInsights.lastThirdOfTheNight),
//         currentPrayer: prayerTimes.currentPrayer(),
//         nextPrayer: prayerTimes.nextPrayer(),
//         timeForCurrentPrayer: _formatPrayerTime(
//           prayerTimes.timeForPrayer(prayerTimes.currentPrayer()),
//         ),

//         timeForNextPrayer: _formatPrayerTime(
//           prayerTimes.timeForPrayer(prayerTimes.nextPrayer()),
//         ),
//       );
//     } catch (e) {
//       print('Error calculating prayer times: $e');
//       return _getFallbackPrayerTimes(date);
//     }
//   }

//   static Future<PrayerTimesModel> getCurrentPrayerTimes({
//     required double latitude,
//     required double longitude,
//     CalculationMethod method = CalculationMethod.karachi,
//     dynamic madhab = PrayerMadhab.hanafi,
//   }) async {
//     return calculatePrayerTimes(
//       latitude: latitude,
//       longitude: longitude,
//       date: DateTime.now(),
//       method: method,
//       madhab: madhab,
//     );
//   }
//   // Add this method to your PrayerTimeCalculator class (lib/utils/prayer_time_calculator.dart)

//   static Future<PrayerTimesModel> getPrayerTimesForCity({
//     required String city,
//     DateTime? date,
//     CalculationMethod method = CalculationMethod.karachi,
//     dynamic madhab = PrayerMadhab.hanafi,
//   }) async {
//     final parsedMadhab = _parseMadhab(madhab);

//     final cityCoordinates = {
//       'Makkah': Coordinates(21.3891, 39.8579),
//       'Madinah': Coordinates(24.5247, 39.5692),
//       'Jeddah': Coordinates(21.5433, 39.1728),
//       'Riyadh': Coordinates(24.7136, 46.6753),
//       'Dubai': Coordinates(25.2048, 55.2708),
//       'Kuwait': Coordinates(29.3759, 47.9774),
//       'Doha': Coordinates(25.2854, 51.5310),
//       'Manama': Coordinates(26.2285, 50.5860),
//       'Muscat': Coordinates(23.5880, 58.3829),
//       'Karachi': Coordinates(24.8607, 67.0011),
//       'Lahore': Coordinates(31.5204, 74.3587),
//       'Islamabad': Coordinates(33.6844, 73.0479),
//       'Delhi': Coordinates(28.6139, 77.2090),
//       'Mumbai': Coordinates(19.0760, 72.8777),
//       'Dhaka': Coordinates(23.8103, 90.4125),
//       'London': Coordinates(51.5074, -0.1278),
//       'New York': Coordinates(40.7128, -74.0060),
//     };

//     final coordinates = cityCoordinates[city];
//     if (coordinates == null) {
//       throw Exception('City not found: $city');
//     }

//     return calculatePrayerTimes(
//       latitude: coordinates.latitude,
//       longitude: coordinates.longitude,
//       date: date ?? DateTime.now(),
//       method: method,
//       madhab: parsedMadhab,
//     );
//   }

//   static PrayerCalculationParameters _getCalculationMethod(
//     CalculationMethod method,
//   ) {
//     switch (method) {
//       case CalculationMethod.muslimWorldLeague:
//         return PrayerCalculationMethod.muslimWorldLeague();
//       case CalculationMethod.egyptian:
//         return PrayerCalculationMethod.egyptian();
//       case CalculationMethod.karachi:
//         return PrayerCalculationMethod.karachi();
//       case CalculationMethod.ummAlQura:
//         return PrayerCalculationMethod.ummAlQura();
//       case CalculationMethod.dubai:
//         return PrayerCalculationMethod.dubai();
//       case CalculationMethod.moonsightingCommittee:
//         return PrayerCalculationMethod.moonsightingCommittee();
//       case CalculationMethod.northAmerica:
//         return PrayerCalculationMethod.northAmerica();
//       case CalculationMethod.kuwait:
//         return PrayerCalculationMethod.kuwait();
//       case CalculationMethod.qatar:
//         return PrayerCalculationMethod.qatar();
//       case CalculationMethod.singapore:
//         return PrayerCalculationMethod.singapore();
//       case CalculationMethod.tehran:
//         return PrayerCalculationMethod.tehran();
//       case CalculationMethod.turkey:
//         return PrayerCalculationMethod.turkey();
//       default:
//         return PrayerCalculationMethod.karachi();
//     }
//   }

//   static String _formatPrayerTime(DateTime? time) {
//     if (time == null) return '--:-- --';

//     String hour = time.hour > 12
//         ? (time.hour - 12).toString().padLeft(2, '0')
//         : time.hour.toString().padLeft(2, '0');

//     if (time.hour == 0) hour = '12';

//     String minute = time.minute.toString().padLeft(2, '0');
//     String period = time.hour >= 12 ? 'PM' : 'AM';

//     return '$hour:$minute $period';
//   }

//   static String _getTimezoneName(int offsetMinutes) {
//     if (offsetMinutes == 300) return 'Asia/Karachi';
//     if (offsetMinutes == 180) return 'Asia/Riyadh';
//     if (offsetMinutes == 240) return 'Asia/Dubai';
//     if (offsetMinutes == 330) return 'Asia/Kolkata';
//     if (offsetMinutes == 360) return 'Asia/Dhaka';
//     return 'UTC';
//   }

//   static String _getHijriDate(DateTime date) {
//     final islamicMonths = [
//       'Muharram',
//       'Safar',
//       'Rabi\' al-Awwal',
//       'Rabi\' al-Thani',
//       'Jumada al-Awwal',
//       'Jumada al-Thani',
//       'Rajab',
//       'Sha\'ban',
//       'Ramadan',
//       'Shawwal',
//       'Dhu al-Qi\'dah',
//       'Dhu al-Hijjah',
//     ];

//     final hijriYear = date.year - 622 + ((date.month - 1) ~/ 12);
//     final hijriMonth = ((date.month + 8) % 12) + 1;
//     final hijriDay = date.day;

//     return '$hijriDay ${islamicMonths[hijriMonth - 1]} $hijriYear AH';
//   }

//   static PrayerTimesModel _getFallbackPrayerTimes(DateTime date) {
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
//       hijriDate: '1 Ramadan 1445 AH',
//       qiblaDirection: 276.0,
//       middleOfNight: '12:00 AM',
//       lastThirdOfNight: '2:00 AM',
//       currentPrayer: 'Fajr',
//       nextPrayer: 'Sunrise',
//       timeForCurrentPrayer: '5:15 AM',
//       timeForNextPrayer: '6:30 AM',
//     );
//   }
// }

// enum CalculationMethod {
//   muslimWorldLeague,
//   egyptian,
//   karachi,
//   ummAlQura,
//   dubai,
//   moonsightingCommittee,
//   northAmerica,
//   kuwait,
//   qatar,
//   singapore,
//   tehran,
//   turkey,
// }
