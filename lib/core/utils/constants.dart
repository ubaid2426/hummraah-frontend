// lib/utils/constants.dart

class AppConstants {
  // App Info
  static const String appName = 'Hummraah';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = 'https://api.hummraah.com/v1';
  // static const String baseUrl = 'https://api.hummraah.com/v1';
  static const String prayerTimesEndpoint = '/prayer-times';
  static const String duasEndpoint = '/duas';
  static const String packagesEndpoint = '/packages';
  
  // Shared Preferences Keys
  static const String prefLanguage = 'language';
  static const String prefTheme = 'theme';
  static const String prefUser = 'user';
  static const String prefBookings = 'bookings';
  
  // Notification Channels
  static const String prayerChannelId = 'prayer_reminders';
  static const String prayerChannelName = 'Prayer Reminders';
  static const String permitChannelId = 'permit_reminders';
  static const String permitChannelName = 'Permit Reminders';
  
  // Journey Steps
  static const List<String> journeySteps = [
    'Pre-Umrah Preparation',
    'Travel & Logistics',
    'Umrah Ritual Guidance',
    'Ziyarah Planner',
    'During Stay Services',
    'Return & Follow-up',
  ];
  
  // Package Types
  static const List<String> packageTypes = [
    'Premium',
    'Economy',
    'Family',
    'Individual',
  ];
  
  // Supported Languages
  static const List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'ur', 'name': 'اردو', 'flag': '🇵🇰'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
  ];
}