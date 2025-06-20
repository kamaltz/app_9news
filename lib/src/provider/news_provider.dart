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
  List<NewsArticle> _searchedArticles = [];
  bool _isSearchLoading = false;
  String? _searchError;

  // State untuk Bookmarks Page
  List<NewsArticle> _bookmarkedArticles = [];
  bool _isBookmarkLoading = false;

  // State untuk User Articles
  List<NewsArticle> _userArticles = [];
  bool _isUserArticlesLoading = false;

  // Getters
  List<NewsArticle> get trendingArticles => _trendingArticles;
  List<NewsArticle> get latestArticles => _latestArticles;
  bool get isHomepageLoading => _isHomepageLoading;
  List<NewsArticle> get searchedArticles => _searchedArticles;
  bool get isSearchLoading => _isSearchLoading;
  String? get searchError => _searchError;
  List<NewsArticle> get bookmarkedArticles => _bookmarkedArticles;
  bool get isBookmarkLoading => _isBookmarkLoading;
  List<NewsArticle> get userArticles => _userArticles;
  bool get isUserArticlesLoading => _isUserArticlesLoading;

  // --- Homepage ---
  Future<void> fetchHomepageData() async {
    _isHomepageLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait([
        _newsService.fetchTrendingNews(limit: 5),
        _newsService.fetchLatestNews(limit: 10),
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

  // --- Explore ---
  Future<void> searchArticles({String? query, String? category}) async {
    _isSearchLoading = true;
    _searchError = null;
    notifyListeners();
    try {
      _searchedArticles = await _newsService.fetchLatestNews(
          query: query, category: category, limit: 20);
    } catch (e) {
      _searchError = e.toString();
    } finally {
      _isSearchLoading = false;
      notifyListeners();
    }
  }

  // --- Bookmarks ---
  Future<void> fetchBookmarkedArticles() async {
    _isBookmarkLoading = true;
    notifyListeners();
    try {
      _bookmarkedArticles = await _newsService.getBookmarkedArticles();
    } catch (e) {
      // handle error
    } finally {
      _isBookmarkLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleBookmark(String articleId) async {
    final isBookmarked =
        _bookmarkedArticles.any((article) => article.id == articleId);
    try {
      if (isBookmarked) {
        await _newsService.removeBookmark(articleId);
        _bookmarkedArticles.removeWhere((article) => article.id == articleId);
      } else {
        await _newsService.addBookmark(articleId);
        await fetchBookmarkedArticles();
      }
      notifyListeners();
    } catch (e) {
      // handle error
    }
  }

  // --- User Articles ---
  Future<void> fetchUserArticles() async {
    _isUserArticlesLoading = true;
    notifyListeners();
    try {
      _userArticles = await _newsService.getUserArticles();
    } catch (e) {
      // handle error
    } finally {
      _isUserArticlesLoading = false;
      notifyListeners();
    }
  }
}
