// lib/services/location_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../utils/permissions_helper.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  Position? _currentPosition;
  String? _currentAddress;
  double? _lastKnownLatitude;
  double? _lastKnownLongitude;

  // Get current position
  Future<Position?> getCurrentLocation() async {
    try {
      // Check if permission is granted
      bool permissionGranted = await PermissionsHelper.requestLocationPermission();
      
      if (!permissionGranted) {
        throw Exception('Location permission denied');
      }

      // Check if location services are enabled
      bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        throw Exception('Location services are disabled');
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      _lastKnownLatitude = _currentPosition?.latitude;
      _lastKnownLongitude = _currentPosition?.longitude;

      return _currentPosition;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  // Get last known position (faster, less accurate)
  Future<Position?> getLastKnownLocation() async {
    try {
      _currentPosition = await Geolocator.getLastKnownPosition();
      
      if (_currentPosition != null) {
        _lastKnownLatitude = _currentPosition?.latitude;
        _lastKnownLongitude = _currentPosition?.longitude;
      }
      
      return _currentPosition;
    } catch (e) {
      print('Error getting last known location: $e');
      return null;
    }
  }

  // Get address from coordinates
  Future<String?> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _currentAddress = 
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        return _currentAddress;
      }
      return null;
    } catch (e) {
      print('Error getting address: $e');
      return null;
    }
  }

  // Get coordinates from address
  Future<Coordinates?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      
      if (locations.isNotEmpty) {
        Location location = locations[0];
        return Coordinates(location.latitude, location.longitude);
      }
      return null;
    } catch (e) {
      print('Error getting coordinates: $e');
      return null;
    }
  }

  // Calculate distance between two coordinates (in meters)
  Future<double> calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) async {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // Calculate bearing between two coordinates
  double calculateBearing({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.bearingBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  // Get distance to Haram (Makkah)
  Future<Map<String, dynamic>> getDistanceToHaram() async {
    try {
      if (_currentPosition == null) {
        await getCurrentLocation();
      }

      if (_currentPosition != null) {
        // Kaaba coordinates
        const double kaabaLatitude = 21.4225;
        const double kaabaLongitude = 39.8262;

        double distanceInMeters = await calculateDistance(
          startLatitude: _currentPosition!.latitude,
          startLongitude: _currentPosition!.longitude,
          endLatitude: kaabaLatitude,
          endLongitude: kaabaLongitude,
        );

        double bearing = calculateBearing(
          startLatitude: _currentPosition!.latitude,
          startLongitude: _currentPosition!.longitude,
          endLatitude: kaabaLatitude,
          endLongitude: kaabaLongitude,
        );

        return {
          'distance': distanceInMeters,
          'distanceInKm': (distanceInMeters / 1000).toStringAsFixed(2),
          'bearing': bearing,
          'bearingDirection': _getBearingDirection(bearing),
        };
      }
      
      return {'error': 'Location not available'};
    } catch (e) {
      print('Error calculating distance to Haram: $e');
      return {'error': e.toString()};
    }
  }

  // Get bearing direction
  String _getBearingDirection(double bearing) {
    if (bearing >= 337.5 || bearing < 22.5) return 'North';
    if (bearing >= 22.5 && bearing < 67.5) return 'Northeast';
    if (bearing >= 67.5 && bearing < 112.5) return 'East';
    if (bearing >= 112.5 && bearing < 157.5) return 'Southeast';
    if (bearing >= 157.5 && bearing < 202.5) return 'South';
    if (bearing >= 202.5 && bearing < 247.5) return 'Southwest';
    if (bearing >= 247.5 && bearing < 292.5) return 'West';
    if (bearing >= 292.5 && bearing < 337.5) return 'Northwest';
    return 'North';
  }

  // Get city name from coordinates
  Future<String?> getCityFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      
      if (placemarks.isNotEmpty) {
        return placemarks[0].locality ?? placemarks[0].administrativeArea;
      }
      return null;
    } catch (e) {
      print('Error getting city: $e');
      return null;
    }
  }

  // Get country from coordinates
  Future<String?> getCountryFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      
      if (placemarks.isNotEmpty) {
        return placemarks[0].country;
      }
      return null;
    } catch (e) {
      print('Error getting country: $e');
      return null;
    }
  }

  // Stream location updates
  Stream<Position> getLocationStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int interval = 5000, // milliseconds
    int distanceFilter = 0, // meters
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        timeLimit: const Duration(minutes: 5),
        distanceFilter: distanceFilter,
      ),
    );
  }

  // Check if user is in Makkah
  Future<bool> isInMakkah() async {
    try {
      if (_currentPosition == null) {
        await getCurrentLocation();
      }

      if (_currentPosition != null) {
        const double makkahLatitude = 21.3891;
        const double makkahLongitude = 39.8579;
        const double radiusInKm = 50; // 50km radius

        double distance = await calculateDistance(
          startLatitude: _currentPosition!.latitude,
          startLongitude: _currentPosition!.longitude,
          endLatitude: makkahLatitude,
          endLongitude: makkahLongitude,
        );

        return distance <= radiusInKm * 1000;
      }
      
      return false;
    } catch (e) {
      print('Error checking location: $e');
      return false;
    }
  }

  // Check if user is in Madinah
  Future<bool> isInMadinah() async {
    try {
      if (_currentPosition == null) {
        await getCurrentLocation();
      }

      if (_currentPosition != null) {
        const double madinahLatitude = 24.5247;
        const double madinahLongitude = 39.5692;
        const double radiusInKm = 50; // 50km radius

        double distance = await calculateDistance(
          startLatitude: _currentPosition!.latitude,
          startLongitude: _currentPosition!.longitude,
          endLatitude: madinahLatitude,
          endLongitude: madinahLongitude,
        );

        return distance <= radiusInKm * 1000;
      }
      
      return false;
    } catch (e) {
      print('Error checking location: $e');
      return false;
    }
  }

  // Get current location with detailed info
  Future<Map<String, dynamic>> getCurrentLocationDetails() async {
    try {
      Position position = await getCurrentLocation() as Position;
      String? address = await getAddressFromCoordinates(position.latitude, position.longitude);
      String? city = await getCityFromCoordinates(position.latitude, position.longitude);
      String? country = await getCountryFromCoordinates(position.latitude, position.longitude);
      Map<String, dynamic> haramDistance = await getDistanceToHaram();

      return {
        'position': position,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'altitude': position.altitude,
        'accuracy': position.accuracy,
        'speed': position.speed,
        'heading': position.heading,
        'timestamp': position.timestamp,
        'address': address,
        'city': city,
        'country': country,
        'haramDistance': haramDistance,
        'isInMakkah': await isInMakkah(),
        'isInMadinah': await isInMadinah(),
      };
    } catch (e) {
      print('Error getting location details: $e');
      return {'error': e.toString()};
    }
  }

  // Get nearby places (requires additional API)
  Future<List<Map<String, dynamic>>> getNearbyPlaces({
    required String type, // 'mosque', 'restaurant', 'hotel', etc.
    double radiusInMeters = 1000,
  }) async {
    // This would typically use Google Places API or similar
    // For now, return empty list
    return [];
  }

  // Clear cached location data
  void clearCache() {
    _currentPosition = null;
    _currentAddress = null;
    _lastKnownLatitude = null;
    _lastKnownLongitude = null;
  }

  // Get cached position
  Position? getCachedPosition() {
    return _currentPosition;
  }

  // Get cached address
  String? getCachedAddress() {
    return _currentAddress;
  }

  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Open location settings
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // Open app settings
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}

// Helper class for coordinates
class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates(this.latitude, this.longitude);

  @override
  String toString() => 'Coordinates(lat: $latitude, lng: $longitude)';
}

// Extension for easy distance formatting
extension DistanceFormatting on double {
  String toReadableDistance() {
    if (this < 1000) {
      return '${toStringAsFixed(0)} m';
    } else {
      return '${(this / 1000).toStringAsFixed(2)} km';
    }
  }
}