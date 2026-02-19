import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl = 'https://mobile-api.legacy-nwi.com';

  // SharedPreferences keys (only used when Remember Me is on)
  static const String _keyAccessToken = 'access_token';
  static const String _keyUserData = 'user_data';
  static const String _keyRememberMe = 'remember_me';
  static const String _keySavedEmail = 'saved_email';

  // In-memory session (used when Remember Me is off — cleared on app restart)
  static String? _memAccessToken;
  static UserModel? _memUser;

  // ─────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────

  /// Safely decode JSON — returns null if the body is not valid JSON.
  static Map<String, dynamic>? _tryDecode(String body) {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Human-readable message from a caught exception.
  static String _errorMessage(Object e) {
    if (e is SocketException) return 'No internet connection.';
    if (e is HttpException) return 'Server error. Please try again.';
    if (e is FormatException) return 'Unexpected server response.';
    return 'Something went wrong: $e';
  }

  // ─────────────────────────────────────────────
  // LOGIN
  // ─────────────────────────────────────────────

  /// POST /api/auth/login
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = _tryDecode(response.body);

      if (response.statusCode == 200 && data != null) {
        return {'success': true, 'data': data};
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        final message = data?['error'] ?? data?['detail'] ?? 'Login failed.';
        return {'success': false, 'message': message};
      } else {
        return {
          'success': false,
          'message': data?['error'] ?? 'Something went wrong (${response.statusCode}).'
        };
      }
    } catch (e) {
      return {'success': false, 'message': _errorMessage(e)};
    }
  }

  // ─────────────────────────────────────────────
  // FORGOT PASSWORD — SEND OTP
  // ─────────────────────────────────────────────

  /// POST /api/auth/forgot-password
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/auth/forgot-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final data = _tryDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'message': data?['message'] ?? 'OTP sent.'};
      }
      return {
        'success': false,
        'message': data?['error'] ?? 'Something went wrong (${response.statusCode}).'
      };
    } catch (e) {
      return {'success': false, 'message': _errorMessage(e)};
    }
  }

  // ─────────────────────────────────────────────
  // VERIFY OTP
  // ─────────────────────────────────────────────

  /// POST /api/auth/verify-otp
  static Future<Map<String, dynamic>> verifyOtp(
      String email, String otpCode) async {
    try {
      final requestBody = {'email': email, 'otp_code': otpCode};
      debugPrint('[AuthService] verifyOtp → POST $_baseUrl/api/auth/verify-otp');
      debugPrint('[AuthService] verifyOtp → body: $requestBody');

      final response = await http.post(
        Uri.parse('$_baseUrl/api/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      debugPrint('[AuthService] verifyOtp ← status: ${response.statusCode}');
      debugPrint('[AuthService] verifyOtp ← body: ${response.body}');

      final data = _tryDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true};
      }

      if (response.statusCode >= 500) {
        return {
          'success': false,
          'message': 'Server error. Please try again later or contact support.'
        };
      }

      return {
        'success': false,
        'message': data?['error'] ?? 'OTP verification failed (${response.statusCode}).'
      };
    } catch (e) {
      debugPrint('[AuthService] verifyOtp ✖ exception: $e');
      return {'success': false, 'message': _errorMessage(e)};
    }
  }

  // ─────────────────────────────────────────────
  // RESET PASSWORD
  // ─────────────────────────────────────────────

  /// POST /api/auth/reset-password
  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otpCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'otp_code': otpCode,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        }),
      );

      final data = _tryDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data?['message'] ?? 'Password reset successfully.'
        };
      }

      final message = data?['error'] ??
          (data?['non_field_errors'] as List?)?.first?.toString() ??
          'Password reset failed (${response.statusCode}).';
      return {'success': false, 'message': message};
    } catch (e) {
      return {'success': false, 'message': _errorMessage(e)};
    }
  }

  // ─────────────────────────────────────────────
  // CHANGE PASSWORD  (auth required)
  // ─────────────────────────────────────────────

  /// PUT /api/auth/change-password
  static Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final token = await getAccessToken();
      if (token == null) {
        return {'success': false, 'message': 'Not authenticated.'};
      }

      final response = await http.put(
        Uri.parse('$_baseUrl/api/auth/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'current_password': currentPassword,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        }),
      );

      final data = _tryDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data?['message'] ?? 'Password changed successfully.'
        };
      }

      final message = data?['error'] ??
          data?['detail'] ??
          (data?['non_field_errors'] as List?)?.first?.toString() ??
          (data?['new_password'] as List?)?.first?.toString() ??
          'Failed to change password (${response.statusCode}).';
      return {'success': false, 'message': message};
    } catch (e) {
      return {'success': false, 'message': _errorMessage(e)};
    }
  }

  // ─────────────────────────────────────────────
  // LOGOUT  (auth required)
  // ─────────────────────────────────────────────

  /// POST /api/auth/logout — invalidates the token server-side, then clears all local data.
  static Future<void> logout() async {
    try {
      final token = await getAccessToken();
      if (token != null) {
        await http.post(
          Uri.parse('$_baseUrl/api/auth/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      }
    } catch (_) {
      // Best-effort — clear locally regardless
    }

    _memAccessToken = null;
    _memUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // ─────────────────────────────────────────────
  // SESSION HELPERS
  // ─────────────────────────────────────────────

  /// - [rememberMe] = true  → persists to SharedPreferences (survives restart).
  /// - [rememberMe] = false → in-memory only (cleared on app close).
  static Future<void> saveSession({
    required String accessToken,
    required UserModel user,
    required bool rememberMe,
    required String email,
  }) async {
    if (rememberMe) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyAccessToken, accessToken);
      await prefs.setString(_keyUserData, user.toJsonString());
      await prefs.setBool(_keyRememberMe, true);
      await prefs.setString(_keySavedEmail, email);
    } else {
      _memAccessToken = accessToken;
      _memUser = user;
    }
  }

  static Future<bool> isLoggedIn() async {
    if (_memAccessToken != null) return true;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken) != null;
  }

  static Future<String?> getAccessToken() async {
    if (_memAccessToken != null) return _memAccessToken;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAccessToken);
  }

  static Future<UserModel?> getUser() async {
    if (_memUser != null) return _memUser;
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUserData);
    if (userJson == null) return null;
    return UserModel.fromJsonString(userJson);
  }

  static Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_keyRememberMe) ?? false;
    if (!rememberMe) return null;
    return prefs.getString(_keySavedEmail);
  }

  static Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRememberMe) ?? false;
  }
}
