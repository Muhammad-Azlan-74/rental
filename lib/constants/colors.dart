import 'package:flutter/material.dart';

class AppColors {
  // Primary gradient colors
  static const Color primaryDark = Color(0xFF1a237e); // Deep Blue
  static const Color primaryLight = Color(0xFF00acc1); // Teal
  
  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  
  // Button colors
  static const Color buttonGradientStart = Color(0xFF1a237e);
  static const Color buttonGradientEnd = Color(0xFF00acc1);
  
  // Success/Error colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  
  // Input field colors
  static const Color inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocusBorder = Color(0xFF00acc1);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primaryLight],
  );
}
