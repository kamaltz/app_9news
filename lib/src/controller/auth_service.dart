// lib/src/controller/auth_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:app_9news/src/models/auth_model.dart'; // Pastikan path impor ini benar
import 'package:flutter/foundation.dart';

class AuthService {
  // Base URL dari dokumentasi API Anda
  static const String _baseUrl = 'https://kamaltz.fun/api/v1';
  
  AuthService() {
    // Untuk development, bypass certificate verification
    if (kDebugMode) {
      HttpOverrides.global = MyHttpOverrides();
    }
  }

  /// Fungsi untuk login pengguna
  Future<AuthModel> login(String email, String password) async {
    try {
      // Endpoint sesuai dokumentasi: /auth/login
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        // Body request sesuai dokumentasi: { "email": "...", "password": "..." }
        body: jsonEncode({'email': email, 'password': password}),
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        throw Exception('Koneksi timeout. Periksa koneksi internet Anda.');
      });

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      final responseBody = jsonDecode(response.body);

      // Menurut dokumentasi, respons sukses memiliki status code 200
      if (response.statusCode == 200 && responseBody['success'] == true) {
        return AuthModel.fromJson(responseBody);
      } else {
        // Jika gagal, lemparkan pesan error dari API
        throw Exception(responseBody['message'] ?? 'Gagal login');
      }
    } catch (e) {
      print('Login error: ${e.toString()}');
      if (e is SocketException) {
        throw Exception('Tidak dapat terhubung ke server. Periksa koneksi internet Anda.');
      }
      throw Exception('Gagal login: ${e.toString()}');
    }
  }

  /// Fungsi untuk registrasi pengguna baru
  Future<AuthModel> register(Map<String, dynamic> userData) async {
    try {
      // Endpoint sesuai dokumentasi: /auth/register
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        // Body request sesuai dokumentasi: { "email", "password", "name", "title", "avatar" }
        // userData sudah berisi map dengan semua field yang dibutuhkan.
        body: jsonEncode(userData),
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        throw Exception('Koneksi timeout. Periksa koneksi internet Anda.');
      });

      print('Register response status: ${response.statusCode}');
      print('Register response body: ${response.body}');

      final responseBody = jsonDecode(response.body);

      // Menurut dokumentasi dan standar REST API, registrasi sukses mengembalikan status code 201 (Created)
      if (response.statusCode == 201 && responseBody['success'] == true) {
        return AuthModel.fromJson(responseBody);
      } else {
        // Jika gagal, lemparkan pesan error dari API
        throw Exception(responseBody['message'] ?? 'Gagal registrasi');
      }
    } catch (e) {
      print('Register error: ${e.toString()}');
      if (e is SocketException) {
        throw Exception('Tidak dapat terhubung ke server. Periksa koneksi internet Anda.');
      }
      throw Exception('Gagal registrasi: ${e.toString()}');
    }
  }
}

// Class untuk bypass certificate verification pada development
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
