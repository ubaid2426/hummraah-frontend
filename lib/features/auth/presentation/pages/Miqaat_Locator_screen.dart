// // lib/screens/miqaat_locator_screen_simple.dart
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';

// class MiqaatLocatorScreenSimple extends StatefulWidget {
//   const MiqaatLocatorScreenSimple({super.key});

//   @override
//   State<MiqaatLocatorScreenSimple> createState() => _MiqaatLocatorScreenSimpleState();
// }

// class _MiqaatLocatorScreenSimpleState extends State<MiqaatLocatorScreenSimple> {
//   Position? _currentPosition;
//   String _currentAddress = 'Detecting location...';
//   String _nearestMiqaat = '';
//   double _distanceToNearestMiqaat = 0;
//   bool _isLoading = true;

//   final List<Map<String, dynamic>> _miqaatLocations = [
//     {'name': 'Dhul Hulayfah', 'arabic': 'ذو الحليفة', 'lat': 24.4221, 'lon': 39.6033, 'description': 'Miqaat for people coming from Madinah and beyond', 'distanceFromMakkah': 450},
//     {'name': 'Al-Juhfah', 'arabic': 'الجحفة', 'lat': 22.6915, 'lon': 39.0596, 'description': 'Miqaat for people coming from Syria, Egypt, and beyond', 'distanceFromMakkah': 183},
//     {'name': 'Qarn al-Manazil', 'arabic': 'قرن المنازل', 'lat': 21.5571, 'lon': 40.1128, 'description': 'Miqaat for people coming from Najd and beyond', 'distanceFromMakkah': 75},
//     {'name': 'Yalamlam', 'arabic': 'يلملم', 'lat': 19.9289, 'lon': 40.1268, 'description': 'Miqaat for people coming from Yemen and beyond', 'distanceFromMakkah': 120},
//     {'name': 'Dhat Irq', 'arabic': 'ذات عرق', 'lat': 22.0748, 'lon': 41.2365, 'description': 'Miqaat for people coming from Iraq and beyond', 'distanceFromMakkah': 94},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissionsAndGetLocation();
//   }

//   Future<void> _checkPermissionsAndGetLocation() async {
//     setState(() => _isLoading = true);

//     PermissionStatus permission = await Permission.location.status;
//     if (!permission.isGranted) {
//       permission = await Permission.location.request();
//     }

//     if (permission.isGranted) {
//       await _getCurrentLocation();
//     } else {
//       setState(() {
//         _currentAddress = 'Location permission denied';
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         setState(() {
//           _currentAddress = 'Location services disabled';
//           _isLoading = false;
//         });
//         return;
//       }

//       _currentPosition = await Geolocator.getCurrentPosition();

//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         _currentPosition!.latitude,
//         _currentPosition!.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         setState(() {
//           _currentAddress = '${placemarks[0].locality ?? placemarks[0].subLocality}, ${placemarks[0].country}';
//         });
//       }

//       _findNearestMiqaat();
//       setState(() => _isLoading = false);
//     } catch (e) {
//       setState(() {
//         _currentAddress = 'Unable to get location';
//         _isLoading = false;
//       });
//     }
//   }

//   void _findNearestMiqaat() {
//     if (_currentPosition == null) return;

//     double minDistance = double.infinity;
//     String nearest = '';

//     for (var miqaat in _miqaatLocations) {
//       double distance = Geolocator.distanceBetween(
//         _currentPosition!.latitude,
//         _currentPosition!.longitude,
//         miqaat['lat'] as double,
//         miqaat['lon'] as double,
//       );

//       if (distance < minDistance) {
//         minDistance = distance;
//         nearest = miqaat['name'] as String;
//       }
//     }

//     setState(() {
//       _nearestMiqaat = nearest;
//       _distanceToNearestMiqaat = minDistance / 1000;
//     });
//   }

//   void _openInGoogleMaps(double lat, double lon) async {
//     final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Miqaat Locator'),
//         backgroundColor: Colors.green,
//         foregroundColor: Colors.white,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Card(
//                     child: ListTile(
//                       leading: const Icon(Icons.my_location, color: Colors.green),
//                       title: const Text('Your Location'),
//                       subtitle: Text(_currentAddress),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.refresh),
//                         onPressed: _getCurrentLocation,
//                       ),
//                     ),
//                   ),
//                   if (_nearestMiqaat.isNotEmpty)
//                     Card(
//                       color: Colors.green,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             const Text(
//                               'Nearest Miqaat',
//                               style: TextStyle(color: Colors.white70),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               _nearestMiqaat,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               '${_distanceToNearestMiqaat.toStringAsFixed(1)} km away',
//                               style: const TextStyle(color: Colors.white70),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'All Miqaats',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   ..._miqaatLocations.map((miqaat) => Card(
//                         child: ListTile(
//                           leading: const Icon(Icons.location_on, color: Colors.green),
//                           title: Text(miqaat['name'] as String),
//                           subtitle: Text(miqaat['description'] as String),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.map),
//                             onPressed: () => _openInGoogleMaps(
//                               miqaat['lat'] as double,
//                               miqaat['lon'] as double,
//                             ),
//                           ),
//                           onTap: () => _openInGoogleMaps(
//                             miqaat['lat'] as double,
//                             miqaat['lon'] as double,
//                           ),
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//     );
//   }
// }




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/colors.dart';

class MiqaatLocation {
  final String name;
  final String nameArabic;
  final LatLng coordinates;
  final String description;
  final double distanceFromMakkah;
  final String routeFromMakkah;

  MiqaatLocation({
    required this.name,
    required this.nameArabic,
    required this.coordinates,
    required this.description,
    required this.distanceFromMakkah,
    required this.routeFromMakkah,
  });
}

class MiqaatLocatorScreen extends StatefulWidget {
  const MiqaatLocatorScreen({super.key});

  @override
  State<MiqaatLocatorScreen> createState() => _MiqaatLocatorScreenState();
}

class _MiqaatLocatorScreenState extends State<MiqaatLocatorScreen> {
  MapController? _mapController;
  Position? _currentPosition;
  String _currentAddress = 'Detecting location...';
  String _nearestMiqaat = '';
  double _distanceToNearestMiqaat = 0;
  bool _isLoading = true;
  bool _hasPermission = false;

  final List<Marker> _markers = [];

  final List<MiqaatLocation> _miqaatLocations = [
    MiqaatLocation(
      name: 'Dhul Hulayfah',
      nameArabic: 'ذو الحليفة',
      coordinates: const LatLng(24.4221, 39.6033),
      description: 'Miqaat for people coming from Madinah and beyond',
      distanceFromMakkah: 450,
      routeFromMakkah: 'Via Madinah Road',
    ),
    MiqaatLocation(
      name: 'Al-Juhfah',
      nameArabic: 'الجحفة',
      coordinates: const LatLng(22.6915, 39.0596),
      description: 'Miqaat for people coming from Syria, Egypt, and beyond',
      distanceFromMakkah: 183,
      routeFromMakkah: 'Via coastal road',
    ),
    MiqaatLocation(
      name: 'Qarn al-Manazil',
      nameArabic: 'قرن المنازل',
      coordinates: const LatLng(21.5571, 40.1128),
      description: 'Miqaat for people coming from Najd and beyond',
      distanceFromMakkah: 75,
      routeFromMakkah: 'Via Taif road',
    ),
    MiqaatLocation(
      name: 'Yalamlam',
      nameArabic: 'يلملم',
      coordinates: const LatLng(19.9289, 40.1268),
      description: 'Miqaat for people coming from Yemen and beyond',
      distanceFromMakkah: 120,
      routeFromMakkah: 'Via southern road',
    ),
    MiqaatLocation(
      name: 'Dhat Irq',
      nameArabic: 'ذات عرق',
      coordinates: const LatLng(22.0748, 41.2365),
      description: 'Miqaat for people coming from Iraq and beyond',
      distanceFromMakkah: 94,
      routeFromMakkah: 'Via eastern road',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndGetLocation();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _checkPermissionsAndGetLocation() async {
    setState(() => _isLoading = true);

    // Check location permission
    PermissionStatus permission = await Permission.location.status;

    if (!permission.isGranted) {
      // Show popup dialog for permission
      _showLocationPermissionDialog();
      return;
    }

    if (permission.isGranted) {
      setState(() => _hasPermission = true);
      await _getCurrentLocation();
    } else {
      setState(() {
        _currentAddress = 'Location permission denied';
        _isLoading = false;
        _hasPermission = false;
      });
    }
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Permission Required',
          style: TextStyle(color: Colors.green),
        ),
        content: const Text(
          'Miqaat Locator needs your location to find the nearest Miqaat and show accurate directions.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isLoading = false;
                _hasPermission = false;
                _currentAddress = 'Location permission denied';
              });
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // Request permission
              PermissionStatus permission = await Permission.location.request();
              
              if (permission.isGranted) {
                setState(() => _hasPermission = true);
                await _getCurrentLocation();
              } else {
                setState(() {
                  _isLoading = false;
                  _hasPermission = false;
                  _currentAddress = 'Location permission denied';
                });
                
                // If permanently denied, show settings dialog
                if (permission.isPermanentlyDenied) {
                  _showSettingsDialog();
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
            ),
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Permission Required',
          style: TextStyle(color: Colors.green),
        ),
        content: const Text(
          'Location permission is needed to find the nearest Miqaat. Please enable it in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
              // Check permission again after returning
              _checkPermissionsAndGetLocation();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
            ),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Services Disabled',
          style: TextStyle(color: Colors.green),
        ),
        content: const Text(
          'Please enable location services to find the nearest Miqaat.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isLoading = false;
                _currentAddress = 'Location services disabled';
              });
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
              _checkPermissionsAndGetLocation();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
            ),
            child: const Text('Enable Location'),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() => _isLoading = true);
      
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationServiceDialog();
        return;
      }

      // Get current position with timeout
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Location request timeout');
        },
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      if (placemarks.isNotEmpty) {
        setState(() {
          _currentAddress =
              '${placemarks[0].locality ?? placemarks[0].subLocality ?? placemarks[0].administrativeArea}, ${placemarks[0].country ?? ''}';
        });
      }

      // Find nearest miqaat
      _findNearestMiqaat();

      // Prepare markers
      _prepareMarkers();

      setState(() {
        _isLoading = false;
        _hasPermission = true;
      });

      // Center map on current location
      if (_mapController != null && _currentPosition != null) {
        _mapController!.move(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          8.0,
        );
      }
    } catch (e) {
      setState(() {
        _currentAddress = 'Unable to get location';
        _isLoading = false;
      });
      print('Error getting location: $e');
      _showErrorDialog('Failed to get location. Please try again.');
    }
  }

  void _prepareMarkers() {
    _markers.clear();

    // Add miqaat markers
    for (var miqaat in _miqaatLocations) {
      _markers.add(
        Marker(
          point: miqaat.coordinates,
          width: 60,
          height: 60,
          child: GestureDetector(
            onTap: () => _showMiqaatDetails(miqaat),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    miqaat.name,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Add current location marker
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          point: LatLng(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          width: 40,
          height: 40,
          child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
        ),
      );
    }
  }

  void _findNearestMiqaat() {
    if (_currentPosition == null) return;

    double minDistance = double.infinity;
    String nearest = '';

    for (var miqaat in _miqaatLocations) {
      double distance = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        miqaat.coordinates.latitude,
        miqaat.coordinates.longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        nearest = miqaat.name;
      }
    }

    setState(() {
      _nearestMiqaat = nearest;
      _distanceToNearestMiqaat = minDistance / 1000; // Convert to km
    });
  }

  void _openInGoogleMaps(LatLng coordinates, String name) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${coordinates.latitude},${coordinates.longitude}';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorDialog('Could not open Google Maps');
    }
  }

  void _getDirections(LatLng destination, String destinationName) async {
    if (_currentPosition == null) {
      _showErrorDialog('Current location not available');
      return;
    }

    final url =
        'https://www.google.com/maps/dir/${_currentPosition!.latitude},${_currentPosition!.longitude}/${destination.latitude},${destination.longitude}/';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorDialog('Could not open directions');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showMiqaatDetails(MiqaatLocation miqaat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              miqaat.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              miqaat.nameArabic,
              style: const TextStyle(fontSize: 18, color: Color(0xFFE6B566)),
            ),
            const SizedBox(height: 16),
            Text(
              miqaat.description,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 16,
                        color: Color(0xFF2C5F2D),
                      ),
                      const SizedBox(width: 8),
                      const Text('Distance from Makkah:'),
                      const Spacer(),
                      Text('${miqaat.distanceFromMakkah} km'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.route_rounded,
                        size: 16,
                        color: Color(0xFFE6B566),
                      ),
                      const SizedBox(width: 8),
                      const Text('Route:'),
                      const Spacer(),
                      Text(miqaat.routeFromMakkah),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        _openInGoogleMaps(miqaat.coordinates, miqaat.name),
                    icon: const Icon(Icons.map_rounded),
                    label: const Text('Open in Maps'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _getDirections(miqaat.coordinates, miqaat.name),
                    icon: const Icon(Icons.directions_rounded),
                    label: const Text('Get Directions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Miqaat Locator'),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_hasPermission
              ? _buildPermissionDeniedWidget()
              : _currentPosition == null
                  ? _buildRetryWidget()
                  : Column(
                      children: [
                        // Current Location Card
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryGreen.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.my_location_rounded,
                                  color: Color(0xFF2C5F2D),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Your Location',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      _currentAddress,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.refresh_rounded),
                                onPressed: _getCurrentLocation,
                              ),
                            ],
                          ),
                        ),

                        // Nearest Miqaat Card
                        if (_nearestMiqaat.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryGold,
                                  AppColors.primaryTerracotta,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Nearest Miqaat',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _nearestMiqaat,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${_distanceToNearestMiqaat.toStringAsFixed(1)} km away',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Map
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FlutterMap(
                                mapController: _mapController,
                                options: MapOptions(
                                  initialCenter: _currentPosition != null
                                      ? LatLng(
                                          _currentPosition!.latitude,
                                          _currentPosition!.longitude,
                                        )
                                      : const LatLng(21.4225, 39.8262),
                                  initialZoom: 8.0,
                                  onTap: (tapPosition, point) {
                                    // Handle map tap if needed
                                  },
                                ),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                    userAgentPackageName: 'com.example.app',
                                  ),
                                  MarkerLayer(markers: _markers),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Miqaat List
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'All Miqaats',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (_mapController != null &&
                                              _currentPosition != null) {
                                            _mapController!.move(
                                              LatLng(
                                                _currentPosition!.latitude,
                                                _currentPosition!.longitude,
                                              ),
                                              8.0,
                                            );
                                          }
                                        },
                                        child: const Text('Center Map'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: _miqaatLocations.length,
                                    itemBuilder: (context, index) {
                                      final miqaat = _miqaatLocations[index];
                                      return ListTile(
                                        leading: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryGreen
                                                .withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                              color: Color(0xFF2C5F2D),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        title: Text(miqaat.name),
                                        subtitle: Text(miqaat.description),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.map_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () =>
                                                  _openInGoogleMaps(
                                                miqaat.coordinates,
                                                miqaat.name,
                                              ),
                                              color: AppColors.primaryGold,
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.directions_rounded,
                                                size: 20,
                                              ),
                                              onPressed: () => _getDirections(
                                                miqaat.coordinates,
                                                miqaat.name,
                                              ),
                                              color: AppColors.primaryGreen,
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          _showMiqaatDetails(miqaat);
                                          if (_mapController != null) {
                                            _mapController!.move(
                                              miqaat.coordinates,
                                              12.0,
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }

  Widget _buildPermissionDeniedWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            const Text(
              'Location Access Required',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              _currentAddress == 'Location permission denied'
                  ? 'Please allow location access to find the nearest Miqaat.'
                  : 'Location permission is needed to show accurate Miqaat locations.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _showLocationPermissionDialog,
              icon: const Icon(Icons.location_on),
              label: const Text('Allow Location Access'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRetryWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_searching, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            const Text(
              'Unable to Get Location',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              _currentAddress,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}