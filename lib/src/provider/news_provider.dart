// lib/src/provider/news_provider.dart

import 'package:flutter/material.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/controller/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  // State untuk Homepage
  List<NewsArticle> _trendingArticles = [];
  List<NewsArticle> _latestArticles = [];
  bool _isHomepageLoading = false;

  // State untuk Explore Page
  List<NewsArticle> _exploreArticles = [];
  bool _isExploreLoading = false;
  String? _exploreError;
  String _selectedCategory = 'Semua';
  final List<String> _categories = [
    "Semua",
    "Nasional",
    "Teknologi",
    "Bola",
    "Internasional",
    "Trending"
  ];

  // State lainnya
  List<NewsArticle> _bookmarkedArticles = [];
  bool _isBookmarkLoading = false;
  List<NewsArticle> _userArticles = [];
  bool _isUserArticlesLoading = false;

  // Getters
  List<NewsArticle> get trendingArticles => _trendingArticles;
  List<NewsArticle> get latestArticles => _latestArticles;
  bool get isHomepageLoading => _isHomepageLoading;
  List<NewsArticle> get exploreArticles => _exploreArticles;
  bool get isExploreLoading => _isExploreLoading;
  String? get exploreError => _exploreError;
  String get selectedCategory => _selectedCategory;
  List<String> get categories => _categories;
  List<NewsArticle> get bookmarkedArticles => _bookmarkedArticles;
  bool get isBookmarkLoading => _isBookmarkLoading;
  List<NewsArticle> get userArticles => _userArticles;
  bool get isUserArticlesLoading => _isUserArticlesLoading;

  Future<void> fetchHomepageData() async {
    _isHomepageLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _newsService.fetchArticles(isTrending: true, limit: 5),
        _newsService.fetchArticles(limit: 10),
      ]);
      _trendingArticles = results[0];
      _latestArticles = results[1];
    } catch (e) {
      // Handle error
    } finally {
      _isHomepageLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchExploreArticles({String? query}) async {
    _isExploreLoading = true;
    _exploreError = null;
    notifyListeners();
    try {
      _exploreArticles = await _newsService.fetchArticles(
          query: query,
          category: _selectedCategory == 'Semua' ? null : _selectedCategory,
          limit: 20);
    } catch (e) {
      _exploreError = e.toString();
    } finally {
      _isExploreLoading = false;
      notifyListeners();
    }
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
    fetchExploreArticles(); // Muat ulang berita dengan kategori baru
  }

  // ... (Fungsi CRUD Bookmark dan User Articles tetap sama)
  Future<void> fetchBookmarkedArticles() async {
    _isBookmarkLoading = true;
    notifyListeners();
    try {
      _bookmarkedArticles = await _newsService.getBookmarkedArticles();
    } catch (e) {/* handle error */} finally {
      _isBookmarkLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleBookmark(String articleId) async {
    final isBookmarked = _bookmarkedArticles.any((a) => a.id == articleId);
    try {
      if (isBookmarked) {
        await _newsService.removeBookmark(articleId);
        _bookmarkedArticles.removeWhere((a) => a.id == articleId);
      } else {
        await _newsService.addBookmark(articleId);
        await fetchBookmarkedArticles();
      }
      notifyListeners();
    } catch (e) {/* handle error */}
  }

  Future<void> fetchUserArticles() async {
    _isUserArticlesLoading = true;
    notifyListeners();
    try {
      _userArticles = await _newsService.getUserArticles();
    } catch (e) {/* handle error */} finally {
      _isUserArticlesLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createArticle(Map<String, dynamic> articleData) async {
    _isUserArticlesLoading = true;
    notifyListeners();
    try {
      await _newsService.createArticle(articleData);
      await fetchHomepageData(); // Refresh homepage
      await fetchUserArticles(); // Refresh profil
      return true;
    } catch (e) {
      return false;
    } finally {
      _isUserArticlesLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateArticle(
      String articleId, Map<String, dynamic> articleData) async {
    _isUserArticlesLoading = true;
    notifyListeners();
    try {
      await _newsService.updateArticle(articleId, articleData);
      await fetchHomepageData();
      await fetchUserArticles();
      return true;
    } catch (e) {
      return false;
    } finally {
      _isUserArticlesLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteArticle(String articleId) async {
    try {
      final success = await _newsService.deleteArticle(articleId);
      if (success) {
        _userArticles.removeWhere((a) => a.id == articleId);
        await fetchHomepageData();
        notifyListeners();
      }
    } catch (e) {/* Handle error */}
  }
}
