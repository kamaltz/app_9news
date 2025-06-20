// lib/src/models/auth_model.dart

class AuthModel {
  final bool success;
  final String message;
  final UserData data;

  AuthModel({required this.success, required this.message, required this.data});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      // Mengambil objek 'data' dari JSON dan mem-parsingnya menggunakan UserData.fromJson
      data: UserData.fromJson(json['data'] ?? {}),
    );
  }
}

class UserData {
  final String token;
  final User user;

  UserData({required this.token, required this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      // Mem-parsing token dan user dari dalam objek 'data'
      token: json['token'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String? title;
  final String? avatar;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.title,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      title: json['title'] as String?,
      avatar: json['avatar'] as String?,
    );
  }
}
