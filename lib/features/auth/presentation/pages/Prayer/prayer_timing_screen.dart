// lib/screens/prayer_timing_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/permissions_helper.dart';
import '../../../data/models/prayer_model.dart';
import 'prayer_setting_model.dart';
import 'prayer_setting_screen.dart';
import 'timing_bloc.dart';

enum TimingProps { Fajr, Dhuhr, Asr, Maghrib, Isha }

class PrayerTimingScreen extends StatefulWidget {
  const PrayerTimingScreen({super.key});

  @override
  State<PrayerTimingScreen> createState() => _PrayerTimingScreenState();
}

class _PrayerTimingScreenState extends State<PrayerTimingScreen> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  Timer? _timer;
  String _remainingTime = '';
  DateTime? _nextPrayerTime;
  TimingProps? _currentTiming;
  PrayerSettings? _settings;
  bool _isLoading = true;
  String? _errorMessage;
  double? _latitude;
  double? _longitude;
  bool _hasLocationPermission = false;

  final Map<TimingProps, String> _backgroundAsset = {
    TimingProps.Fajr: 'assets/images/praying_time/svg/morning.png',
    TimingProps.Dhuhr: 'assets/images/praying_time/svg/noon.png',
    TimingProps.Asr: 'assets/images/praying_time/svg/afternoon.png',
    TimingProps.Maghrib: 'assets/images/praying_time/svg/evening.png',
    TimingProps.Isha: 'assets/images/praying_time/svg/night.png',
  };

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    await _loadSettings();
    await _checkPermissionAndGetLocation();
    _startTimer();
  }

  Future<void> _loadSettings() async {
    final methodStr = await _secureStorage.read(key: 'calculation_method');
    final madhabStr = await _secureStorage.read(key: 'madhab');
    final useManual = await _secureStorage.read(key: 'use_manual_location');
    final latStr = await _secureStorage.read(key: 'manual_latitude');
    final longStr = await _secureStorage.read(key: 'manual_longitude');

    setState(() {
      _settings = PrayerSettings(
        calculationMethod: methodStr != null
            ? CalculationMethod.values.firstWhere(
                (e) => e.toString() == methodStr,
                orElse: () => CalculationMethod.karachi,
              )
            : CalculationMethod.karachi,
        madhab: madhabStr != null
            ? Madhab.values.firstWhere(
                (e) => e.toString() == madhabStr,
                orElse: () => Madhab.hanafi,
              )
            : Madhab.hanafi,
        useManualLocation: useManual == 'true',
        manualLatitude: latStr != null ? double.tryParse(latStr) : null,
        manualLongitude: longStr != null ? double.tryParse(longStr) : null,
      );
    });
  }

  Future<void> _checkPermissionAndGetLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // First, check if using manual location from settings
      if (_settings!.useManualLocation && 
          _settings!.manualLatitude != null && 
          _settings!.manualLongitude != null) {
        _latitude = _settings!.manualLatitude;
        _longitude = _settings!.manualLongitude;
        _hasLocationPermission = true;
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Location permission is required to show accurate prayer times. Please enable location permission in settings or use manual location.';
            _hasLocationPermission = false;
            _isLoading = false;
          });
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage = 'Location permission permanently denied. Please enable location permission in device settings or use manual location.';
          _hasLocationPermission = false;
          _isLoading = false;
        });
        return;
      }
      
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'Location services are disabled. Please enable GPS to get accurate prayer times, or use manual location in settings.';
          _hasLocationPermission = false;
          _isLoading = false;
        });
        return;
      }
      
      // Get current location
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      _latitude = position.latitude;
      _longitude = position.longitude;
      _hasLocationPermission = true;
      
      // Save to storage
      await _secureStorage.write(key: 'latitude', value: _latitude.toString());
      await _secureStorage.write(key: 'longitude', value: _longitude.toString());
      
      setState(() {
        _isLoading = false;
      });
      
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get location: $e';
        _hasLocationPermission = false;
        _isLoading = false;
      });
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Permission Required',
          style: TextStyle(color: AppColors.primaryGreen),
        ),
        content: const Text(
          'Prayer times need your location to show accurate prayer schedules for your area. You can also use manual location in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToSettings();
            },
            child: const Text('Use Manual Location'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // Open app settings
              await Geolocator.openAppSettings();
              // Retry after returning from settings
              _checkPermissionAndGetLocation();
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
          'Please enable location services to get accurate prayer times for your area, or use manual location in settings.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToSettings();
            },
            child: const Text('Use Manual Location'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
              _checkPermissionAndGetLocation();
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

  void _navigateToSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrayerSettingsScreen(),
      ),
    );
    if (result == true) {
      await _loadSettings();
      await _checkPermissionAndGetLocation();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_nextPrayerTime != null && mounted) {
        setState(() {
          _remainingTime = _getRemainingTime(DateTime.now(), _nextPrayerTime!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show loading state
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Prayer Timing"),
          centerTitle: true,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: _navigateToSettings,
            ),
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading...'),
            ],
          ),
        ),
      );
    }

    // Show permission required screen
    if (!_hasLocationPermission || _errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Prayer Timing"),
          centerTitle: true,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: _navigateToSettings,
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_off,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Location Permission Required',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _errorMessage ?? 'Please enable location permission to get accurate prayer times for your area.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showPermissionDialog,
                    icon: const Icon(Icons.location_on),
                    label: const Text('Grant Location Permission'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _navigateToSettings,
                    icon: const Icon(Icons.settings),
                    label: const Text('Use Manual Location'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Show prayer times screen
    if (_latitude == null || _longitude == null || _settings == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Prayer Timing"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _navigateToSettings,
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => TimingBloc(
          latitude: _latitude!,
          longitude: _longitude!,
          method: _settings!.getApiMethodCode(),
          madhab: _settings!.getApiMadhabCode(),
        )..add(LoadTimingEvent()),
        child: BlocBuilder<TimingBloc, TimingState>(
          builder: (context, state) {
            if (state is TimingLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Fetching prayer times...'),
                  ],
                ),
              );
            } else if (state is TimingLoaded) {
              final prayerTimes = state.prayerTimes;
              final now = DateTime.now();
              final nextPrayer = _getNextPrayer(prayerTimes, now);

              if (nextPrayer != null) {
                _nextPrayerTime = nextPrayer['time'];
                _currentTiming = nextPrayer['timing'];
                _remainingTime = _getRemainingTime(now, _nextPrayerTime!);
              }

              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            _backgroundAsset[_currentTiming] ??
                                _backgroundAsset[TimingProps.Fajr]!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.black.withOpacity(0.6),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date: ${HijriCalendarConfig.now().toFormat("dd MMMM yyyy")}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Hijri: ${prayerTimes.hijriDate}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${_latitude!.toStringAsFixed(2)}°, ${_longitude!.toStringAsFixed(2)}°',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Method: ${_settings!.calculationMethod.getDisplayName()}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Next Prayer: ${nextPrayer?['name'] ?? 'Unknown'}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _formatTime(_nextPrayerTime!),
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Time Remaining: $_remainingTime',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildPrayerTimings(prayerTimes),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is TimingError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.read<TimingBloc>().add(LoadTimingEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }

  Widget _buildPrayerTimings(PrayerTimesModel prayerTimes) {
    final timings = {
      'Fajr': prayerTimes.getPrayerTime('Fajr'),
      'Dhuhr': prayerTimes.getPrayerTime('Dhuhr'),
      'Asr': prayerTimes.getPrayerTime('Asr'),
      'Maghrib': prayerTimes.getPrayerTime('Maghrib'),
      'Isha': prayerTimes.getPrayerTime('Isha'),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: Column(
        children: timings.entries.map((entry) {
          final time = _formatTime(entry.value);
          final isNext = _nextPrayerTime == entry.value;
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: TextStyle(
                    color: isNext ? Colors.green : Colors.white,
                    fontSize: 16,
                    fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: isNext ? Colors.green : Colors.white,
                    fontSize: 16,
                    fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Map<String, dynamic>? _getNextPrayer(PrayerTimesModel prayerTimes, DateTime now) {
    final prayerSchedule = {
      TimingProps.Fajr: prayerTimes.getPrayerTime('Fajr'),
      TimingProps.Dhuhr: prayerTimes.getPrayerTime('Dhuhr'),
      TimingProps.Asr: prayerTimes.getPrayerTime('Asr'),
      TimingProps.Maghrib: prayerTimes.getPrayerTime('Maghrib'),
      TimingProps.Isha: prayerTimes.getPrayerTime('Isha'),
    };

    final upcomingPrayers = prayerSchedule.entries
        .where((entry) => entry.value.isAfter(now))
        .toList();

    if (upcomingPrayers.isEmpty) {
      final tomorrowFajr = prayerTimes.getPrayerTime('Fajr').add(const Duration(days: 1));
      return {
        'name': 'Fajr', 
        'time': tomorrowFajr, 
        'timing': TimingProps.Fajr
      };
    }

    upcomingPrayers.sort((a, b) => a.value.compareTo(b.value));
    final nextPrayer = upcomingPrayers.first;

    return {
      'name': nextPrayer.key.name,
      'time': nextPrayer.value,
      'timing': nextPrayer.key,
    };
  }

  String _formatTime(DateTime time) {
    int hour = time.hour;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  String _getRemainingTime(DateTime now, DateTime prayerTime) {
    final duration = prayerTime.difference(now);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}