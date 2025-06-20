// lib/src/models/auth_model.dart

class AuthModel {
  final UserData data; // Asumsikan respons API memiliki kunci 'data'

  AuthModel({required this.data});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      data: UserData.fromJson(
        json,
      ), // Menguraikan seluruh JSON sebagai UserData
    );
  }
}

class UserData {
  final String token;
  final User user;

  UserData({required this.token, required this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      // Asumsikan token dan data user berada langsung di root response
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String title;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.title = '',
    this.avatar = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      title: json['title'] as String? ?? '', // Menangani nilai null
      avatar: json['avatar'] as String? ?? '', // Menangani nilai null
    );
  }
}
