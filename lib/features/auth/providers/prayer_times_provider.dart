// // lib/providers/prayer_times_provider.dart
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import '../../../core/services/location_service.dart';
// import '../../../core/utils/prayer_time_calculator.dart';
// import '../data/models/prayer_times_model.dart';
// // import '../models/prayer_times_model.dart';
// // import '../utils/prayer_time_calculator.dart';
// // import '../services/location_service.dart';

// class PrayerTimesProvider extends ChangeNotifier {
//   PrayerTimesModel? _prayerTimes;
//   bool _isLoading = false;
//   String? _error;
//   String _selectedCity = 'Makkah';
//   Position? _currentPosition;
  
//   PrayerTimesModel? get prayerTimes => _prayerTimes;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   String get selectedCity => _selectedCity;
  
//   PrayerTimesProvider() {
//     initializePrayerTimes();
//   }
  
//   Future<void> initializePrayerTimes() async {
//     _isLoading = true;
//     notifyListeners();
    
//     try {
//       // Try to get current location
//       _currentPosition = await LocationService().getCurrentLocation();
      
//       if (_currentPosition != null) {
//         await getPrayerTimesForLocation(
//           latitude: _currentPosition!.latitude,
//           longitude: _currentPosition!.longitude,
//         );
//       } else {
//         // Fallback to Makkah
//         await getPrayerTimesForCity('Makkah');
//       }
//     } catch (e) {
//       _error = e.toString();
//       // Fallback to Makkah
//       await getPrayerTimesForCity('Makkah');
//     }
    
//     _isLoading = false;
//     notifyListeners();
//   }
  
//   Future<void> getPrayerTimesForLocation({
//     required double latitude,
//     required double longitude,
//   }) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
    
//     try {
//       _prayerTimes = await PrayerTimeCalculator.getCurrentPrayerTimes(
//         latitude: latitude,
//         longitude: longitude,
//       );
//     } catch (e) {
//       _error = e.toString();
//     }
    
//     _isLoading = false;
//     notifyListeners();
//   }
  
//   Future<void> getPrayerTimesForCity(String city) async {
//     _isLoading = true;
//     _error = null;
//     _selectedCity = city;
//     notifyListeners();
    
//     try {
//       _prayerTimes = await PrayerTimeCalculator.getPrayerTimesForCity(
//         city: city,
//       );
//     } catch (e) {
//       _error = e.toString();
//     }
    
//     _isLoading = false;
//     notifyListeners();
//   }
  
//   Future<void> refreshPrayerTimes() async {
//     if (_currentPosition != null) {
//       await getPrayerTimesForLocation(
//         latitude: _currentPosition!.latitude,
//         longitude: _currentPosition!.longitude,
//       );
//     } else {
//       await getPrayerTimesForCity(_selectedCity);
//     }
//   }
  
//   void selectCity(String city) {
//     if (_selectedCity != city) {
//       getPrayerTimesForCity(city);
//     }
//   }
// }