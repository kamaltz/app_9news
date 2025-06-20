// lib/src/controller/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_9news/src/models/auth_model.dart'; // Pastikan path impor ini benar

class AuthService {
  // Base URL dari dokumentasi API Anda
  static const String _baseUrl = 'https://rest-api-berita.vercel.app/api/v1';

  /// Fungsi untuk login pengguna
  Future<AuthModel> login(String email, String password) async {
    // Endpoint sesuai dokumentasi: /auth/login
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      // Body request sesuai dokumentasi: { "email": "...", "password": "..." }
      body: jsonEncode({'email': email, 'password': password}),
    );

    final responseBody = jsonDecode(response.body);

    // Menurut dokumentasi, respons sukses memiliki status code 200
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return AuthModel.fromJson(responseBody);
    } else {
      // Jika gagal, lemparkan pesan error dari API
      throw Exception(responseBody['message'] ?? 'Gagal login');
    }
  }

  /// Fungsi untuk registrasi pengguna baru
  Future<AuthModel> register(Map<String, dynamic> userData) async {
    // Endpoint sesuai dokumentasi: /auth/register
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      // Body request sesuai dokumentasi: { "email", "password", "name", "title", "avatar" }
      // userData sudah berisi map dengan semua field yang dibutuhkan.
      body: jsonEncode(userData),
    );

    final responseBody = jsonDecode(response.body);

    // Menurut dokumentasi dan standar REST API, registrasi sukses mengembalikan status code 201 (Created)
    if (response.statusCode == 201 && responseBody['success'] == true) {
      return AuthModel.fromJson(responseBody);
    } else {
      // Jika gagal, lemparkan pesan error dari API
      throw Exception(responseBody['message'] ?? 'Gagal registrasi');
    }
  }
}
