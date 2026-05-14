// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';

import '../../../core/services/local_storage_service.dart';
import '../data/models/user_data.dart';

class AuthProvider extends ChangeNotifier {
  UserData? _currentUser;
  bool _isLoading = false;
  String? _error;
  String? _token;
  String? _savedEmail;
  
  String? get token => _token;
  String? get savedEmail => _savedEmail;
  
  final LocalStorageService _storageService = LocalStorageService();

  UserData? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    _checkSavedUser();
    _loadSavedEmail();
  }

  Future<void> _checkSavedUser() async {
    final userData = _storageService.getObject('user');
    final savedToken = _storageService.getString('token');

    if (userData != null) {
      _currentUser = UserData.fromJson(userData);
      _token = savedToken;
      notifyListeners();
    }
  }

  // Add this method to load saved email
  Future<void> _loadSavedEmail() async {
    _savedEmail = _storageService.getString('saved_email');
    notifyListeners();
  }

  // Add this method to save email
  Future<void> saveEmail(String email) async {
    await _storageService.setString('saved_email', email);
    _savedEmail = email;
    notifyListeners();
  }

  // Add this method to get saved email
  String? getSavedEmail() {
    return _savedEmail;
  }

  // Add this method to clear saved email
  Future<void> clearSavedEmail() async {
    await _storageService.remove('saved_email');
    _savedEmail = null;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));

      // ✅ DUMMY TOKEN (replace later with API)
      _token = "dummy_token_123";

      _currentUser = UserData(
        id: '1',
        name: 'Abdullah Khan',
        email: email,
        phone: '+92 300 0000000',
        nationality: 'Pakistan',
        passportNumber: 'AB123456',
        profileImage: '',
        cnic: '',
      );

      await _storageService.setObject('user', _currentUser!.toJson());
      await _storageService.setString('token', _token!);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _storageService.remove('user');
    await _storageService.remove('token');
    // Optionally don't clear saved email on logout
    // await _storageService.remove('saved_email');

    _currentUser = null;
    _token = null;

    notifyListeners();
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      _currentUser = UserData.fromJson(userData);
      await _storageService.setObject('user', _currentUser!.toJson());

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  void updateUser(String name, String phone) {
    if (_currentUser != null) {
      _currentUser = UserData(
        id: _currentUser!.id,
        name: name,
        email: _currentUser!.email,
        phone: phone,
        nationality: _currentUser!.nationality,
        passportNumber: _currentUser!.passportNumber,
        profileImage: _currentUser!.profileImage,
        cnic: _currentUser!.cnic,
      );

      _storageService.setObject('user', _currentUser!.toJson());
      notifyListeners();
    }
  }
}