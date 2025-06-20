import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_9news/src/models/auth_model.dart'; // Pastikan AuthModel Anda memiliki UserData dan User

// Ubah nama kelas kembali menjadi AuthService
class AuthService {
  static const String _baseUrl = 'https://rest-api-berita.vercel.app/api/v1';

  // Metode login, sekarang mengembalikan AuthModel yang berisi data atau melempar Exception
  Future<AuthModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      // Melemparkan Exception agar AuthProvider bisa menangkap dan menampilkan error
      throw Exception(jsonDecode(response.body)['message'] ?? 'Gagal login');
    }
  }

  // Metode register, sekarang mengembalikan AuthModel yang berisi data atau melempar Exception
  Future<AuthModel> register(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      return AuthModel.fromJson(jsonDecode(response.body));
    } else {
      // Melemparkan Exception agar AuthProvider bisa menangkap dan menampilkan error
      throw Exception(
        jsonDecode(response.body)['message'] ?? 'Gagal registrasi',
      );
    }
  }
}
