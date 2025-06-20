// lib/src/utils/auth_guard.dart

import 'package:shared_preferences/shared_preferences.dart';
// Tidak perlu lagi mengimpor material.dart atau app_routes.dart di sini,
// karena AuthGuard tidak lagi melakukan navigasi.

class AuthGuard {
  static Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') != null;
  }

  // Perbaikan: Hapus BuildContext dari parameter metode ini.
  // Metode ini sekarang hanya memberi tahu apakah pengguna harus dialihkan ke halaman login atau tidak.
  static Future<bool> shouldRedirectToLogin() async {
    return !(await isAuthenticated());
  }

  // Anda bisa menambahkan metode lain di sini jika dibutuhkan untuk pemeriksaan otentikasi lainnya
  // tanpa melibatkan BuildContext.
}
