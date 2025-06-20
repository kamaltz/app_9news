// lib/src/provider/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:app_9news/src/controller/auth_service.dart';
import 'package:app_9news/src/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoggedIn = false;
  String? _authToken;
  User? _user;

  // Getters untuk diakses oleh UI
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user;

  AuthProvider() {
    _loadUserSession(); // Cek sesi login saat aplikasi dimulai
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Menyimpan token dan data user ke SharedPreferences
  Future<void> _saveUserSession(String token, User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    _authToken = token;
    _user = user;
    _isLoggedIn = true;
  }

  // Memeriksa token dari SharedPreferences untuk menjaga user tetap login
  Future<void> _loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      _authToken = token;
      _isLoggedIn = true;
      // Di aplikasi nyata, Anda mungkin ingin memuat ulang data pengguna dari API di sini
      // untuk memastikan data selalu terbaru.
      notifyListeners();
    }
  }

  /// Fungsi untuk menangani proses login dari UI
  Future<void> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final authModel = await _authService.login(email, password);
      await _saveUserSession(authModel.data.token, authModel.data.user);
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
    } finally {
      _setLoading(false);
    }
  }

  /// Fungsi untuk menangani proses registrasi dari UI
  Future<bool> register(Map<String, dynamic> userData) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final authModel = await _authService.register(userData);
      await _saveUserSession(authModel.data.token, authModel.data.user);
      return true; // Mengembalikan true jika registrasi dan penyimpanan sesi berhasil
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
      return false; // Mengembalikan false jika gagal
    } finally {
      _setLoading(false);
    }
  }

  /// Menghapus pesan error setelah ditampilkan
  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Fungsi untuk logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _isLoggedIn = false;
    _authToken = null;
    _user = null;
    notifyListeners();
  }
}
