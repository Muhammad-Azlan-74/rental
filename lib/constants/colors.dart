import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primaryDark = Color(0xFF0D1B2A);  // Dark Navy
  static const Color primaryLight = Colors.white;       // White

  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);

  // Button gradient — two dark shades so white text stays readable throughout
  static const Color buttonGradientStart = Color(0xFF0D1B2A);
  static const Color buttonGradientEnd = Color(0xFF1B3A5C);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);

  // Input field colors
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocusBorder = Color(0xFF0D1B2A);

  // Gradient (headers, buttons, splash)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [buttonGradientStart, buttonGradientEnd],
  );
}
