// lib/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/themes.dart';
// import '../utils/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _followSystemTheme = true;
  final String _themePrefKey = 'theme_mode';
  final String _followSystemKey = 'follow_system';

  ThemeProvider() {
    _loadThemePreference();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get followSystemTheme => _followSystemTheme;

  ThemeData get currentTheme => 
      _themeMode == ThemeMode.dark ? AppTheme.darkTheme : AppTheme.lightTheme;

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeMode = prefs.getString(_themePrefKey);
      final savedFollowSystem = prefs.getBool(_followSystemKey) ?? true;
      
      _followSystemTheme = savedFollowSystem;
      
      if (!_followSystemTheme) {
        if (savedThemeMode != null) {
          _themeMode = savedThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
        }
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme preference: $e');
    }
  }

  Future<void> toggleTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (_followSystemTheme) {
        // If currently following system, switch to manual mode
        _followSystemTheme = false;
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        _themeMode = brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      } else {
        // Toggle between light and dark
        _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      }
      
      await prefs.setBool(_followSystemKey, _followSystemTheme);
      await prefs.setString(_themePrefKey, _themeMode == ThemeMode.dark ? 'dark' : 'light');
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      _followSystemTheme = false;
      _themeMode = mode;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_followSystemKey, false);
      await prefs.setString(_themePrefKey, mode == ThemeMode.dark ? 'dark' : 'light');
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting theme mode: $e');
    }
  }

  Future<void> setFollowSystemTheme(bool follow) async {
    try {
      _followSystemTheme = follow;
      
      if (follow) {
        // Reset to system theme
        _themeMode = ThemeMode.system;
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_followSystemKey, follow);
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting follow system theme: $e');
    }
  }

  // Get current brightness based on theme mode
  Brightness get brightness {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
    return _themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light;
  }
}

// Extension for easy theme access in widgets
extension ThemeProviderExtension on BuildContext {
  ThemeProvider get themeProvider => Provider.of<ThemeProvider>(this, listen: false);
  bool get isDarkMode => themeProvider.isDarkMode;
  bool get followSystemTheme => themeProvider.followSystemTheme;
}