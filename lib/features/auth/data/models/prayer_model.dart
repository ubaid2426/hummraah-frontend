// lib/models/prayer_times_model.dart
class PrayerTimesModel {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final DateTime date;
  final String hijriDate;  // Add this field
  
  PrayerTimesModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.date,
    required this.hijriDate,  // Add this parameter
  });
  
  factory PrayerTimesModel.fromJson(Map<String, dynamic> json, DateTime date) {
    final timings = json['data']['timings'];
    final hijri = json['data']['date']['hijri'];
    
    // Format hijri date
    final hijriDate = '${hijri['day']} ${hijri['month']['en']} ${hijri['year']}';
    
    return PrayerTimesModel(
      fajr: timings['Fajr'],
      sunrise: timings['Sunrise'],
      dhuhr: timings['Dhuhr'],
      asr: timings['Asr'],
      maghrib: timings['Maghrib'],
      isha: timings['Isha'],
      date: date,
      hijriDate: hijriDate,
    );
  }
  
  DateTime getPrayerTime(String prayerName) {
    String timeString;
    switch (prayerName) {
      case 'Fajr':
        timeString = fajr;
        break;
      case 'Sunrise':
        timeString = sunrise;
        break;
      case 'Dhuhr':
        timeString = dhuhr;
        break;
      case 'Asr':
        timeString = asr;
        break;
      case 'Maghrib':
        timeString = maghrib;
        break;
      case 'Isha':
        timeString = isha;
        break;
      default:
        return date;
    }
    
    // Parse time string like "05:30 (AST)" or "05:30"
    final parts = timeString.split(' ')[0].split(':');
    if (parts.length >= 2) {
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      
      // Handle 12-hour format if needed
      if (timeString.toLowerCase().contains('pm') && hour != 12) {
        hour += 12;
      } else if (timeString.toLowerCase().contains('am') && hour == 12) {
        hour = 0;
      }
      
      return DateTime(date.year, date.month, date.day, hour, minute);
    }
    return date;
  }
  
  // Helper method to get formatted hijri date
  String getFormattedHijriDate() {
    return hijriDate;
  }
}