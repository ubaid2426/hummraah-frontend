// features/auth/presentation/widgets/session_expired_dialog.dart
import 'package:flutter/material.dart';
import 'package:hummraah/core/services/local_storage_service.dart';
import 'package:hummraah/features/auth/presentation/pages/Login_Page/login%20_screen.dart';
// import '../pages/login_screen.dart';

class SessionExpiredDialog {
  static void show(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 60,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Session Expired',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message ?? 'Your session has expired. Please login again to continue.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B6B7A),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Clear all local storage
                      final storage = LocalStorageService();
                      await storage.remove('token');
                      await storage.remove('refreshToken');
                      await storage.remove('user');
                      await storage.remove('userEmail');
                      await storage.remove('userName');
                      
                      // Close dialog
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                      
                      // Navigate to login screen and clear all routes
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login Again',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}