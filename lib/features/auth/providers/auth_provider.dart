// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';

import '../../../core/services/local_storage_service.dart';
import '../data/models/user_data.dart';

class AuthProvider extends ChangeNotifier {
  UserData? _currentUser;
  bool _isLoading = false;
  String? _error;

  final LocalStorageService _storageService = LocalStorageService();

  UserData? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    _checkSavedUser();
  }

  Future<void> _checkSavedUser() async {
    final userData = _storageService.getObject('user');
    if (userData != null) {
      _currentUser = UserData.fromJson(userData);
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Mock login - replace with actual API
      if (email == 'user@example.com' && password == 'password') {
        _currentUser = UserData(
          id: '1',
          name: 'Abdullah Khan',
          email: email,
          phone: '+966 50 123 4567',
          nationality: 'Pakistan',
          passportNumber: 'AB123456',
          profileImage: 'https://via.placeholder.com/150',
        );

        await _storageService.setObject('user', _currentUser!.toJson());
        
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid email or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _storageService.remove('user');
    _currentUser = null;
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
}