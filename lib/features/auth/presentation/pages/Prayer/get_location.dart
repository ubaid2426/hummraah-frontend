import 'dart:async';
// import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:newsome/home_page.dart';
import 'package:qibla_direction/qibla_direction.dart';

// import 'home_page.dart';

/// Main entry point of the application.
// void main() {
//   runApp(const QiblaApp());
// }

/// Main application widget.
const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

class QiblaApp extends StatelessWidget {
  const QiblaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: const QiblaHomePage(),
    );
  }
}

/// Home page widget displaying Qibla direction and location functionalities.
class QiblaHomePage extends StatefulWidget {
  const QiblaHomePage({super.key});

  @override
  State<QiblaHomePage> createState() => _QiblaHomePageState();
}

class _QiblaHomePageState extends State<QiblaHomePage> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<Position>? _positionStreamSubscription;
  Position? _currentPosition;
  double? _qiblaDirection;
  double? _qiblaDistance;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> writePositionToStorage(double latitude, double longitude) async {
    await _secureStorage.write(key: 'latitude', value: latitude.toString());
    await _secureStorage.write(key: 'longitude', value: longitude.toString());
  }

  /// Fetches the current position and calculates the Qibla direction and distance.
  Future<void> _getCurrentPosition() async {
    if (!await _handlePermission()) return;

    final position = await _geolocatorPlatform.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      final coordinate = Coordinate(position.latitude, position.longitude);
      writePositionToStorage(position.latitude, position.longitude);
      // debugPrint(position.latitude as String?);
      _qiblaDirection = QiblaDirection.find(coordinate);
      _qiblaDistance = QiblaDirection.countDistance(coordinate);
      // print(_currentPosition);
    });
  }

  /// Handles location permissions.
  Future<bool> _handlePermission() async {
    if (!await _geolocatorPlatform.isLocationServiceEnabled()) {
      _showErrorDialog('Location services are disabled.');
      return false;
    }

    var permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorDialog('Location permission denied.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showErrorDialog('Location permission denied forever.');
      return false;
    }

    return true;
  }

  /// Shows an error dialog.
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qibla Direction'),
      ),
      body: Center(
        child: _currentPosition == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_qiblaDirection != null) ...[
                    Text(
                      'Qibla Direction: $_qiblaDirection',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Distance to Qibla: ${_qiblaDistance?.toStringAsFixed(2)} km',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _getCurrentPosition,
                    child: const Text('Refresh Location'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => QiblaCompass(
                      //       qiblaDirection: _qiblaDirection!,
                      //     ),
                      //   ),
                      // );
                    },
                    child: const Text('Refresh Location'),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }
}
