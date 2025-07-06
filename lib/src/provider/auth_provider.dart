// lib/src/provider/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:app_9news/src/controller/auth_service.dart';
import 'package:app_9news/src/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Impor untuk json a

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoggedIn = false;
  String? _authToken;
  User? _user;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;
  String? get authToken => _authToken;
  User? get user => _user;

  AuthProvider() {
    _loadUserSession();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _saveUserSession(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);

    // Simpan data user sebagai string JSON
    final userJson = jsonEncode({
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'title': user.title,
      'avatar': user.avatar,
    });
    await prefs.setString('user_data', userJson);

    _authToken = token;
    _user = user;
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> _loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final userDataString = prefs.getString('user_data');

    if (token != null && userDataString != null) {
      _authToken = token;
      _isLoggedIn = true;
      // Muat kembali data user dari JSON
      _user = User.fromJson(jsonDecode(userDataString));
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final authModel = await _authService.login(email, password);
      await _saveUserSession(authModel.data.token, authModel.data.user);
    } catch (e) {
      print('Login error in provider: ${e.toString()}');
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final authModel = await _authService.register(userData);
      await _saveUserSession(authModel.data.token, authModel.data.user);
      return true;
    } catch (e) {
      print('Register error in provider: ${e.toString()}');
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data'); // Hapus juga data user
    _isLoggedIn = false;
    _authToken = null;
    _user = null;
    notifyListeners();
  }
}
