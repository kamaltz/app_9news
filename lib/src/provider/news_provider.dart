// lib/src/provider/news_provider.dart

import 'package:flutter/material.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/controller/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  bool _isLoading = false;
  String? _errorMessage;
  List<NewsArticle> _trendingArticles = [];
  List<NewsArticle> _latestArticles = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<NewsArticle> get trendingArticles => _trendingArticles;
  List<NewsArticle> get latestArticles => _latestArticles;

  Future<void> fetchHomepageData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Ambil data trending dan terbaru secara bersamaan
      final results = await Future.wait([
        _newsService.fetchTrendingNews(limit: 5),
        _newsService.fetchLatestNews(limit: 10),
      ]);
      _trendingArticles = results[0];
      _latestArticles = results[1];
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchArticles(String query) async {
    if (query.isEmpty) {
      fetchHomepageData(); // Jika query kosong, muat ulang data default
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      // API Anda tidak memiliki endpoint pencarian langsung, jadi kita filter berdasarkan kategori
      // Ini adalah contoh, idealnya API memiliki endpoint /search?q=query
      final results = await _newsService.fetchLatestNews(
        category: query,
        limit: 20,
      );
      _latestArticles = results;
      _trendingArticles = []; // Kosongkan trending saat mencari
    } catch (e) {
      _errorMessage = "Gagal mencari berita untuk: $query";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
