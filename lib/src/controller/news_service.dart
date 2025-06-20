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

  // Mengambil berita (digunakan oleh Homepage dan Explore)
  Future<List<NewsArticle>> fetchArticles({
    int page = 1,
    int limit = 10,
    String? category,
    String? query,
    bool? isTrending,
  }) async {
    // Bangun URL secara dinamis
    var uri = Uri.parse('$_baseUrl/news').replace(queryParameters: {
      'page': page.toString(),
      'limit': limit.toString(),
      if (category != null && category.isNotEmpty) 'category': category,
      if (query != null && query.isNotEmpty)
        'title': query, // Asumsi API bisa filter by title
      if (isTrending != null) 'isTrending': isTrending.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> articlesJson =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['articles'];
      // Filter artikel yang tidak memiliki gambar
      final articles = articlesJson
          .map((json) => NewsArticle.fromJson(json))
          .where((article) =>
              article.imageUrl.isNotEmpty &&
              Uri.tryParse(article.imageUrl)?.hasAbsolutePath == true)
          .toList();
      return articles;
    } else {
      throw Exception('Gagal memuat berita');
    }
  }

  // Mengambil detail artikel
  Future<NewsArticle> fetchArticleById(String articleId) async {
    final response = await http.get(Uri.parse('$_baseUrl/news/$articleId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(utf8.decode(response.bodyBytes));
      return NewsArticle.fromJson(jsonData['data']);
    } else {
      throw Exception('Gagal memuat artikel');
    }
  }

  // Mengambil artikel yang di-bookmark oleh user (API sudah handle per user)
  Future<List<NewsArticle>> getBookmarkedArticles() async {
    final headers = await _getAuthHeaders();
    final response = await http.get(Uri.parse('$_baseUrl/news/bookmarks/list'),
        headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> articlesJson =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['articles'];
      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat artikel tersimpan');
    }
  }

  // CRUD Bookmark
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
      return json.decode(utf8.decode(response.bodyBytes))['data']['isSaved'] ??
          false;
    }
    return false;
  }

  // CRUD Artikel Pengguna
  Future<List<NewsArticle>> getUserArticles() async {
    final headers = await _getAuthHeaders();
    final response =
        await http.get(Uri.parse('$_baseUrl/news/user/me'), headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> articlesJson =
          jsonDecode(utf8.decode(response.bodyBytes))['data']['articles'];
      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat artikel pengguna');
    }
  }

  Future<NewsArticle> createArticle(Map<String, dynamic> articleData) async {
    final headers = await _getAuthHeaders();
    final response = await http.post(Uri.parse('$_baseUrl/news'),
        headers: headers, body: jsonEncode(articleData));
    if (response.statusCode == 201) {
      return NewsArticle.fromJson(
          json.decode(utf8.decode(response.bodyBytes))['data']);
    } else {
      throw Exception('Gagal membuat artikel');
    }
  }

  Future<NewsArticle> updateArticle(
      String articleId, Map<String, dynamic> articleData) async {
    final headers = await _getAuthHeaders();
    final response = await http.put(Uri.parse('$_baseUrl/news/$articleId'),
        headers: headers, body: jsonEncode(articleData));
    if (response.statusCode == 200) {
      return NewsArticle.fromJson(
          json.decode(utf8.decode(response.bodyBytes))['data']);
    } else {
      throw Exception('Gagal memperbarui artikel');
    }
  }

  Future<bool> deleteArticle(String articleId) async {
    final headers = await _getAuthHeaders();
    final response = await http.delete(Uri.parse('$_baseUrl/news/$articleId'),
        headers: headers);
    return response.statusCode == 200;
  }
}
