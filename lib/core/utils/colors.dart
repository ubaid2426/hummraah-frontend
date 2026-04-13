// lib/utils/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Inspired by Gulf Sunset
  static const Color primaryGreen = Color(0xFF2C5F2D);
  static const Color primaryGold = Color(0xFFE6B566);
  static const Color primaryTerracotta = Color(0xFFC44536);
  static const Color primaryBlue = Color(0xFF4A6FA5);
  static const Color primaryBrown = Color(0xFF6B4F3C);

  // Secondary Colors
  static const Color softSage = Color(0xFF8FBC8F);
  static const Color desertSand = Color(0xFFF4E4D1);
  static const Color sunsetOrange = Color(0xFFFAA75E);
  static const Color duskPurple = Color(0xFF9B6B9E);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F5F0);
  static const Color backgroundCard = Colors.white;

  // Gradient Combinations
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2C5F2D), Color(0xFF4A6FA5), Color(0xFFE6B566)],
  );

  static const LinearGradient goldGreenGradient = LinearGradient(
    colors: [Color(0xFFE6B566), Color(0xFF2C5F2D)],
  );

  // Glassmorphism effects
  static Color glassWhite = Colors.white.withOpacity(0.7);
  static Color glassLight = Colors.white.withOpacity(0.3);
  static Color glassBorder = Colors.white.withOpacity(0.2);

  // Status Colors
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  static const Color maroon = Color(0xFF800000); // Optional accent
  static const Color darkText = Color(0xFF0D1B2A);
  static const Color greyText = Color(0xFF757575);
  static const Color lightGreyText = Color(0xFF9E9E9E);
  static const Color pageBackground = Color(0xFFF7F8FA);
  static const Color sectionBackground = Color(0xFFF5F5F5);
  static const Color borderGrey = Color(0xFFE0E0E0);
  static const Color successGreen = Color(0xFF2E7D32);
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color warningYellow = Color(0xFFFFC107);
  static const Color whatsappGreen = Color(0xFF25D366);
  static const Color starGold = Color(0xFFFFC107);
  static const Color shadowBlack = Color(0x40000000);
    static const Color white = Color(0xFFFFFFFF); // Base
}
