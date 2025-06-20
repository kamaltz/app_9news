// lib/src/configs/app_routes.dart

import 'package:flutter/material.dart';

// Import semua halaman/widget yang akan digunakan dalam navigasi
import 'package:app_9news/src/views/onboarding/splash_screen.dart';
import 'package:app_9news/src/views/onboarding/introduction1.dart';
import 'package:app_9news/src/views/onboarding/introduction2.dart';
import 'package:app_9news/src/views/onboarding/introduction3.dart';
import 'package:app_9news/src/views/auth/auth_screen.dart'; // Halaman login/register manual
import 'package:app_9news/src/views/homepage.dart'; // Wrapper utama dengan Bottom Nav Bar
import 'package:app_9news/src/views/news/news_detail_page.dart';
import 'package:app_9news/src/views/my_articles_screen.dart';
import 'package:app_9news/src/views/create_edit_article_screen.dart';

class AppRoutes {
  // --- Definisi Konstanta Rute ---
  // Onboarding
  static const String splash = '/';
  static const String introduction1 = '/introduction1';
  static const String introduction2 = '/introduction2';
  static const String introduction3 = '/introduction3';

  // Autentikasi
  static const String login = '/login';

  // Halaman Utama
  static const String home = '/home';

  // Berita
  static const String newsDetail = '/news-detail';

  // Artikel Pengguna
  static const String myArticles = '/my-articles';
  static const String createArticle = '/create-article';
  static const String editArticle = '/edit-article';

  // --- Fungsi untuk Menghasilkan Rute (onGenerateRoute) ---
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
        // Menggunakan AuthScreen yang dibuat secara manual
        return MaterialPageRoute(builder: (_) => const AuthScreen());

      case home:
        // MainWrapper adalah halaman utama dengan BottomNavigationBar
        return MaterialPageRoute(builder: (_) => const MainWrapper());

      case newsDetail:
        // Memeriksa apakah argumen (ID berita) dikirimkan
        if (settings.arguments is String) {
          final articleId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (_) => NewsDetailPage(newsId: articleId),
          );
        }
        // Jika tidak ada argumen, arahkan kembali ke home sebagai fallback
        return MaterialPageRoute(builder: (_) => const MainWrapper());

      case myArticles:
        return MaterialPageRoute(builder: (_) => const MyArticlesScreen());

      case createArticle:
        return MaterialPageRoute(
          builder: (_) => const CreateEditArticleScreen(),
        );

      case editArticle:
        // Memeriksa apakah argumen (Map berisi ID dan data awal) dikirimkan
        if (settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (_) => CreateEditArticleScreen(
              articleId: args['articleId'],
              initialData: args['initialData'],
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const MyArticlesScreen());

      // Rute default jika tidak ada yang cocok
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: Center(
              child: Text('Halaman tidak ditemukan: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
