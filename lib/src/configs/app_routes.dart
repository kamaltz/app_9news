import 'package:flutter/material.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/views/auth/auth_screen.dart';
import 'package:app_9news/src/views/author/author_detail_screen.dart';
import 'package:app_9news/src/views/create_edit_article_screen.dart';
import 'package:app_9news/src/views/homepage.dart';
import 'package:app_9news/src/views/news/news_detail_page.dart';
import 'package:app_9news/src/views/onboarding/introduction1.dart';
import 'package:app_9news/src/views/onboarding/introduction2.dart';
import 'package:app_9news/src/views/onboarding/introduction3.dart';
import 'package:app_9news/src/views/onboarding/splash_screen.dart';

class AppRoutes {
  // --- Definisi Konstanta Rute ---
  static const String splash = '/';
  static const String introduction1 = '/introduction1';
  static const String introduction2 = '/introduction2';
  static const String introduction3 = '/introduction3';
  static const String login = '/login';
  static const String home = '/home';
  static const String newsDetail = '/news-detail';
  static const String authorDetail = '/author-detail';
  static const String createArticle = '/create-article'; // Rute untuk buat/edit

  // --- Fungsi untuk Menghasilkan Rute (onGenerateRoute) ---
  // Pastikan fungsi ini berada DI DALAM kelas AppRoutes
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case introduction1:
        return MaterialPageRoute(builder: (_) => const Introduction1());
      case introduction2:
        return MaterialPageRoute(builder: (_) => const Introduction2());
      case introduction3:
        return MaterialPageRoute(builder: (_) => const Introduction3());
      case login:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainWrapper());
      case newsDetail:
        if (settings.arguments is String) {
          final articleId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => NewsDetailPage(newsId: articleId),
          );
        }
        return _errorRoute();
      case authorDetail:
        if (settings.arguments is Author) {
          final author = settings.arguments as Author;
          return MaterialPageRoute(
            builder: (_) => AuthorDetailScreen(author: author),
          );
        }
        return _errorRoute();
      case createArticle:
        // Halaman ini menangani 'create' (article is null) dan 'edit' (article is not null)
        final article = settings.arguments as NewsArticle?;
        return MaterialPageRoute(
          builder: (_) => CreateEditArticleScreen(article: article),
        );
      default:
        return _errorRoute();
    }
  }

  // Fungsi helper untuk rute error
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(
            child: Text('Halaman tidak ditemukan atau parameter salah.')),
      ),
    );
  }
}
