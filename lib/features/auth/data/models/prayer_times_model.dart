// // lib/models/prayer_times_model.dart
// class PrayerTimesModel {
//   final String fajr;
//   final String fajrEnd;
//   final String sunrise;
//   final String dhuhr;
//   final String dhuhrEnd;
//   final String asr;
//   final String asrEnd;
//   final String maghrib;
//   final String maghribEnd;
//   final String isha;
//   final String ishaEnd;
//   final String nextDayFajr;
//   final String tahajjudEnd;
//   final String sehri;
//   final DateTime date;
//   final String hijriDate;
//   final double qiblaDirection;
//   final String middleOfNight;
//   final String lastThirdOfNight;
//   final String currentPrayer;
//   final String nextPrayer;
//   final String timeForCurrentPrayer;
//   final String timeForNextPrayer;

//   PrayerTimesModel({
//     required this.fajr,
//     required this.fajrEnd,
//     required this.sunrise,
//     required this.dhuhr,
//     required this.dhuhrEnd,
//     required this.asr,
//     required this.asrEnd,
//     required this.maghrib,
//     required this.maghribEnd,
//     required this.isha,
//     required this.ishaEnd,
//     required this.nextDayFajr,
//     required this.tahajjudEnd,
//     required this.sehri,
//     required this.date,
//     required this.hijriDate,
//     required this.qiblaDirection,
//     required this.middleOfNight,
//     required this.lastThirdOfNight,
//     required this.currentPrayer,
//     required this.nextPrayer,
//     required this.timeForCurrentPrayer,
//     required this.timeForNextPrayer,
//   });

//   // Get next prayer info
//   MapEntry<String, String> getNextPrayerInfo() {
//     return MapEntry(nextPrayer, timeForNextPrayer);
//   }

//   // Get current prayer info
//   MapEntry<String, String> getCurrentPrayerInfo() {
//     return MapEntry(currentPrayer, timeForCurrentPrayer);
//   }

//   // Check if it's time for a specific prayer
//   bool isPrayerTime(String prayerName, DateTime currentTime) {
//     // Implementation depends on how you want to check
//     return false;
//   }

//   factory PrayerTimesModel.fromJson(Map<String, dynamic> json, DateTime dateTime) {
//     return PrayerTimesModel(
//       fajr: json['fajr'] ?? '--:-- --',
//       fajrEnd: json['fajrEnd'] ?? '--:-- --',
//       sunrise: json['sunrise'] ?? '--:-- --',
//       dhuhr: json['dhuhr'] ?? '--:-- --',
//       dhuhrEnd: json['dhuhrEnd'] ?? '--:-- --',
//       asr: json['asr'] ?? '--:-- --',
//       asrEnd: json['asrEnd'] ?? '--:-- --',
//       maghrib: json['maghrib'] ?? '--:-- --',
//       maghribEnd: json['maghribEnd'] ?? '--:-- --',
//       isha: json['isha'] ?? '--:-- --',
//       ishaEnd: json['ishaEnd'] ?? '--:-- --',
//       nextDayFajr: json['nextDayFajr'] ?? '--:-- --',
//       tahajjudEnd: json['tahajjudEnd'] ?? '--:-- --',
//       sehri: json['sehri'] ?? '--:-- --',
//       date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
//       hijriDate: json['hijriDate'] ?? '--',
//       qiblaDirection: (json['qiblaDirection'] ?? 0.0).toDouble(),
//       middleOfNight: json['middleOfNight'] ?? '--:-- --',
//       lastThirdOfNight: json['lastThirdOfNight'] ?? '--:-- --',
//       currentPrayer: json['currentPrayer'] ?? 'Fajr',
//       nextPrayer: json['nextPrayer'] ?? 'Sunrise',
//       timeForCurrentPrayer: json['timeForCurrentPrayer'] ?? '--:-- --',
//       timeForNextPrayer: json['timeForNextPrayer'] ?? '--:-- --',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'fajr': fajr,
//       'fajrEnd': fajrEnd,
//       'sunrise': sunrise,
//       'dhuhr': dhuhr,
//       'dhuhrEnd': dhuhrEnd,
//       'asr': asr,
//       'asrEnd': asrEnd,
//       'maghrib': maghrib,
//       'maghribEnd': maghribEnd,
//       'isha': isha,
//       'ishaEnd': ishaEnd,
//       'nextDayFajr': nextDayFajr,
//       'tahajjudEnd': tahajjudEnd,
//       'sehri': sehri,
//       'date': date.toIso8601String(),
//       'hijriDate': hijriDate,
//       'qiblaDirection': qiblaDirection,
//       'middleOfNight': middleOfNight,
//       'lastThirdOfNight': lastThirdOfNight,
//       'currentPrayer': currentPrayer,
//       'nextPrayer': nextPrayer,
//       'timeForCurrentPrayer': timeForCurrentPrayer,
//       'timeForNextPrayer': timeForNextPrayer,
//     };
//   }
// }