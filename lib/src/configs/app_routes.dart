// lib/src/configs/app_routes.dart

import 'package:flutter/material.dart';
// Perbaiki semua jalur impor agar konsisten dan menunjuk ke berkas yang benar
import 'package:app_9news/src/views/create_edit_article_screen.dart';
import 'package:app_9news/src/views/auth/login_screen.dart';
import 'package:app_9news/src/views/homepage.dart'; // Berisi MainWrapperScreen
import 'package:app_9news/src/views/my_articles_screen.dart';
import 'package:app_9news/src/views/auth/register_screen.dart';
import 'package:app_9news/src/views/onboarding/splash_screen.dart';
import 'package:app_9news/src/views/news/news_detail_page.dart';
import 'package:app_9news/src/views/onboarding/introduction1.dart'; // Pastikan jalur ini benar
import 'package:app_9news/src/views/onboarding/introduction2.dart'; // Pastikan jalur ini benar
import 'package:app_9news/src/views/onboarding/introduction3.dart'; // Hanya satu kali impor
import 'package:app_9news/src/views/news/news_list_page.dart';

class AppRoutes {
  static const splash = '/';
  static const introduction1 = '/introduction1';
  static const introduction2 = '/introduction2';
  static const introduction3 = '/introduction3';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const articleDetail = '/article';
  static const profile = '/profile';
  static const explore = '/explore';
  static const trending = '/trending';
  static const saved = '/saved';
  static const myArticles = '/my-articles';
  static const createArticle = '/create-article';
  static const editArticle = '/edit-article';
  static const newslist = '/newslist';
  static const newsdetail = '/newsdetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case introduction1:
        // PERBAIKAN: Gunakan kapitalisasi kelas yang benar (Introduction1)
        return MaterialPageRoute(builder: (_) => const Introduction1());
      case introduction2:
        // PERBAIKAN: Gunakan kapitalisasi kelas yang benar (Introduction2)
        return MaterialPageRoute(builder: (_) => const Introduction2());
      case introduction3:
        // PERBAIKAN: Gunakan kapitalisasi kelas yang benar (Introduction3)
        return MaterialPageRoute(builder: (_) => const Introduction3());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainWrapperScreen());
      case newslist:
        return MaterialPageRoute(builder: (_) => const NewsListPage());
      case articleDetail:
      case newsdetail:
        final newsId = settings.arguments as String?;
        if (newsId != null) {
          return MaterialPageRoute(
            builder: (_) => NewsDetailPage(newsId: newsId),
          );
        }
        return MaterialPageRoute(builder: (_) => const NewsListPage());
      case myArticles:
        return MaterialPageRoute(builder: (_) => const MyArticlesScreen());
      case createArticle:
        return MaterialPageRoute(
          builder: (_) => const CreateEditArticleScreen(),
        );
      case editArticle:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CreateEditArticleScreen(
            articleId: args['articleId'],
            initialData: args['initialData'],
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
