// lib/providers/language_provider.dart
import 'package:flutter/material.dart';
import '../../../core/services/local_storage_service.dart';
class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'en';
  final LocalStorageService _storageService = LocalStorageService();
  
  String get currentLanguage => _currentLanguage;
  
  LanguageProvider() {
    _loadSavedLanguage();
  }
  
  Future<void> _loadSavedLanguage() async {
    final saved = _storageService.getString('language');
    if (saved != null) {
      _currentLanguage = saved;
      notifyListeners();
    }
  }
  
  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage == languageCode) return;
    
    _currentLanguage = languageCode;
    await _storageService.setString('language', languageCode);
    notifyListeners();
  }
  
  Locale get locale => Locale(_currentLanguage);
  
  bool isRTL() {
    return _currentLanguage == 'ar';
  }
}