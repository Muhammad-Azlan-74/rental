import 'dart:convert';

class UserRole {
  final int roleId;
  final String roleName;
  final String description;

  UserRole({
    required this.roleId,
    required this.roleName,
    required this.description,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      roleId: json['role_id'],
      roleName: json['role_name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'role_id': roleId,
        'role_name': roleName,
        'description': description,
      };
}

class UserModel {
  final int userId;
  final String email;
  final String phone;
  final String phoneCountryCode;
  final UserRole role;
  final bool isActive;
  final bool mustChangePassword;
  final String createdAt;
  final String lastLogin;

  UserModel({
    required this.userId,
    required this.email,
    required this.phone,
    required this.phoneCountryCode,
    required this.role,
    required this.isActive,
    required this.mustChangePassword,
    required this.createdAt,
    required this.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      email: json['email'],
      phone: json['phone'] ?? '',
      phoneCountryCode: json['phone_country_code'] ?? '',
      role: UserRole.fromJson(json['role']),
      isActive: json['is_active'] ?? true,
      mustChangePassword: json['must_change_password'] ?? false,
      createdAt: json['created_at'] ?? '',
      lastLogin: json['last_login'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'email': email,
        'phone': phone,
        'phone_country_code': phoneCountryCode,
        'role': role.toJson(),
        'is_active': isActive,
        'must_change_password': mustChangePassword,
        'created_at': createdAt,
        'last_login': lastLogin,
      };

  String toJsonString() => jsonEncode(toJson());

  static UserModel fromJsonString(String jsonString) =>
      UserModel.fromJson(jsonDecode(jsonString));
}
