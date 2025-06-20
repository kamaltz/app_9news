import 'package:flutter/material.dart';
// Perbaiki semua jalur impor untuk menggunakan package:app_9news
import 'package:app_9news/src/views/create_edit_article_screen.dart';
import 'package:app_9news/src/views/auth/login_screen.dart'; // Diperbaiki path
import 'package:app_9news/src/views/main_screen.dart';
import 'package:app_9news/src/views/my_articles_screen.dart';
import 'package:app_9news/src/views/auth/register_screen.dart'; // Diperbaiki path
import 'package:app_9news/lib/introduction/splash_screen.dart'; // Diperbaiki path
import 'package:app_9news/src/views/news/news_detail_page.dart'; // Menggunakan NewsDetailPage yang baru

import 'package:app_9news/lib/introduction/introduction1.dart'; // Tambahkan ini
import 'package:app_9news/lib/introduction/introduction2.dart'; // Tambahkan ini
import 'package:app_9news/lib/introduction/introduction3.dart'; // Tambahkan ini
import 'package:app_9news/src/views/news/news_list_page.dart'; // Tambahkan ini

class AppRoutes {
  static const splash = '/';
  static const introduction1 = '/introduction1'; // Rute untuk introduction1
  static const introduction2 = '/introduction2'; // Rute untuk introduction2
  static const introduction3 = '/introduction3'; // Rute untuk introduction3
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
  static const newslist = '/newslist'; // Tambahkan rute untuk NewsListPage
  static const newsdetail =
      '/newsdetail'; // Tambahkan rute dasar untuk NewsDetailPage

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case introduction1: // Tambahkan case untuk introduction1
        return MaterialPageRoute(builder: (_) => const Introduction1());
      case introduction2: // Tambahkan case untuk introduction2
        return MaterialPageRoute(builder: (_) => const Introduction2());
      case introduction3: // Tambahkan case untuk introduction3
        return MaterialPageRoute(builder: (_) => const Introduction3());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainWrapperScreen());
      case newslist: // Tambahkan case untuk NewsListPage
        return MaterialPageRoute(builder: (_) => const NewsListPage());
      case articleDetail: // Perhatikan: articleDetail Anda adalah /article, bukan /newsdetail
      case newsdetail: // Menangani newsdetail secara terpisah jika artikelDetail digunakan untuk tujuan lain
        final newsId =
            settings.arguments
                as String?; // Argument bisa null jika tidak ada ID
        if (newsId != null) {
          return MaterialPageRoute(
            builder: (_) => NewsDetailPage(newsId: newsId),
          );
        }
        // Fallback jika newsId tidak ada, atau rute tidak cocok
        return MaterialPageRoute(
          builder: (_) => const NewsListPage(),
        ); // Atau halaman error
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
        // Default ke SplashScreen atau halaman login jika rute tidak ditemukan
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
