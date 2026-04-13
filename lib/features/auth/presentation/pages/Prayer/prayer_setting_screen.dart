// lib/screens/prayer_setting_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'prayer_setting_model.dart';

class PrayerSettingsScreen extends StatefulWidget {
  const PrayerSettingsScreen({super.key});

  @override
  State<PrayerSettingsScreen> createState() => _PrayerSettingsScreenState();
}

class _PrayerSettingsScreenState extends State<PrayerSettingsScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  // Initialize with default values
  CalculationMethod _calculationMethod = CalculationMethod.karachi;
  Madhab _madhab = Madhab.hanafi;
  bool _useManualLocation = false;
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }
  
  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }
  
  Future<void> _loadSettings() async {
    try {
      final methodStr = await _storage.read(key: 'calculation_method');
      final madhabStr = await _storage.read(key: 'madhab');
      final useManual = await _storage.read(key: 'use_manual_location');
      final latStr = await _storage.read(key: 'manual_latitude');
      final longStr = await _storage.read(key: 'manual_longitude');
      
      setState(() {
        _calculationMethod = methodStr != null 
            ? CalculationMethod.values.firstWhere(
                (e) => e.toString() == methodStr,
                orElse: () => CalculationMethod.karachi,
              )
            : CalculationMethod.karachi;
            
        _madhab = madhabStr != null
            ? Madhab.values.firstWhere(
                (e) => e.toString() == madhabStr,
                orElse: () => Madhab.hanafi,
              )
            : Madhab.hanafi;
            
        _useManualLocation = useManual == 'true';
        
        if (latStr != null) {
          _latitudeController.text = latStr;
        }
        if (longStr != null) {
          _longitudeController.text = longStr;
        }
        
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading settings: $e');
    }
  }
  
  Future<void> _saveSettings() async {
    await _storage.write(key: 'calculation_method', value: _calculationMethod.toString());
    await _storage.write(key: 'madhab', value: _madhab.toString());
    await _storage.write(key: 'use_manual_location', value: _useManualLocation.toString());
    
    if (_useManualLocation) {
      final lat = double.tryParse(_latitudeController.text);
      final long = double.tryParse(_longitudeController.text);
      
      if (lat != null) {
        await _storage.write(key: 'manual_latitude', value: lat.toString());
      }
      if (long != null) {
        await _storage.write(key: 'manual_longitude', value: long.toString());
      }
    }
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved successfully')),
      );
      Navigator.pop(context, true);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Prayer Settings'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prayer Settings'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Calculation Method',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...CalculationMethod.values.map((method) {
                    return RadioListTile<CalculationMethod>(
                      title: Text(method.getDisplayName()),
                      value: method,
                      groupValue: _calculationMethod,
                      onChanged: (value) {
                        setState(() {
                          _calculationMethod = value!;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Madhab (Fiqh)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...Madhab.values.map((madhab) {
                    return RadioListTile<Madhab>(
                      title: Text(madhab.getDisplayName()),
                      value: madhab,
                      groupValue: _madhab,
                      onChanged: (value) {
                        setState(() {
                          _madhab = value!;
                        });
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text('Use Manual Location'),
                    subtitle: const Text('If disabled, device GPS will be used'),
                    value: _useManualLocation,
                    onChanged: (value) {
                      setState(() {
                        _useManualLocation = value;
                      });
                    },
                  ),
                  if (_useManualLocation) ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: _latitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Latitude',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., 24.8607',
                        helperText: 'Example: 24.8607 for Karachi',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _longitudeController,
                      decoration: const InputDecoration(
                        labelText: 'Longitude',
                        border: OutlineInputBorder(),
                        hintText: 'e.g., 67.0011',
                        helperText: 'Example: 67.0011 for Karachi',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}