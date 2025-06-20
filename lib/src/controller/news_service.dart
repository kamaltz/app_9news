// lib/src/controller/news_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_9news/src/models/news_model.dart';

class NewsService {
  final String _baseUrl = 'https://rest-api-berita.vercel.app/api/v1';

  /// Mengambil daftar semua berita dengan paginasi dan filter
  Future<List<NewsArticle>> fetchLatestNews({
    int page = 1,
    int limit = 10,
    String? category,
  }) async {
    String url = '$_baseUrl/news?page=$page&limit=$limit';
    if (category != null) {
      url += '&category=$category';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      final NewsResponse newsResponse = NewsResponse.fromJson(responseBody);
      return newsResponse.data.articles;
    } else {
      throw Exception('Gagal memuat berita terbaru');
    }
  }

  /// Mengambil berita yang sedang tren
  Future<List<NewsArticle>> fetchTrendingNews({int limit = 5}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/news/trending?limit=$limit'),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      final NewsResponse newsResponse = NewsResponse.fromJson(responseBody);
      return newsResponse.data.articles;
    } else {
      throw Exception('Gagal memuat berita trending');
    }
  }
}
