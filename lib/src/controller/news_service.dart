// lib/src/controller/news_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_9news/src/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsService {
  final String _baseUrl = 'https://rest-api-berita.vercel.app/api/v1';

  // Helper untuk mendapatkan token
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Helper untuk membuat header autentikasi
  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await _getToken();
    if (token == null) throw Exception('Pengguna belum login');
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  // Mengambil berita terbaru (dengan search)
  Future<List<NewsArticle>> fetchLatestNews(
      {int page = 1, int limit = 10, String? category, String? query}) async {
    String url = '$_baseUrl/news?page=$page&limit=$limit';
    if (category != null && category.isNotEmpty) {
      url += '&category=$category';
    }
    // API tidak punya search, jadi kita anggap search by category
    if (query != null && query.isNotEmpty) {
      url += '&category=$query';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return NewsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
          .data
          .articles;
    } else {
      throw Exception('Gagal memuat berita terbaru');
    }
  }

  // Mengambil berita trending
  Future<List<NewsArticle>> fetchTrendingNews({int limit = 5}) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/news/trending?limit=$limit'));
    if (response.statusCode == 200) {
      return NewsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
          .data
          .articles;
    } else {
      throw Exception('Gagal memuat berita trending');
    }
  }

  // Mengambil detail artikel
  Future<NewsArticle> fetchArticleById(String articleId) async {
    final response = await http.get(Uri.parse('$_baseUrl/news/$articleId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      if (jsonData['success'] == true && jsonData['data'] != null) {
        return NewsArticle.fromJson(jsonData['data']);
      } else {
        throw Exception(jsonData['message'] ?? 'Gagal memuat artikel');
      }
    } else {
      throw Exception('Gagal memuat artikel (Status: ${response.statusCode})');
    }
  }

  // --- BARU: Fungsi Bookmark ---
  Future<List<NewsArticle>> getBookmarkedArticles() async {
    final headers = await _getAuthHeaders();
    final response = await http.get(Uri.parse('$_baseUrl/news/bookmarks/list'),
        headers: headers);
    if (response.statusCode == 200) {
      return NewsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
          .data
          .articles;
    } else {
      throw Exception('Gagal memuat artikel tersimpan');
    }
  }

  Future<bool> addBookmark(String articleId) async {
    final headers = await _getAuthHeaders();
    final response = await http.post(
        Uri.parse('$_baseUrl/news/$articleId/bookmark'),
        headers: headers);
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> removeBookmark(String articleId) async {
    final headers = await _getAuthHeaders();
    final response = await http.delete(
        Uri.parse('$_baseUrl/news/$articleId/bookmark'),
        headers: headers);
    return response.statusCode == 200;
  }

  Future<bool> checkBookmarkStatus(String articleId) async {
    final headers = await _getAuthHeaders();
    final response = await http
        .get(Uri.parse('$_baseUrl/news/$articleId/bookmark'), headers: headers);
    if (response.statusCode == 200) {
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      return jsonData['data']['isSaved'] ?? false;
    }
    return false;
  }

  // --- BARU: Fungsi Artikel Pengguna ---
  Future<List<NewsArticle>> getUserArticles() async {
    final headers = await _getAuthHeaders();
    final response =
        await http.get(Uri.parse('$_baseUrl/news/user/me'), headers: headers);
    if (response.statusCode == 200) {
      return NewsResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
          .data
          .articles;
    } else {
      throw Exception('Gagal memuat artikel pengguna');
    }
  }
}
