import 'package:flutter/material.dart';
import 'package:news_app/src/views/login_screen.dart';
import 'package:news_app/main/onboarding/splashscreen/splash_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const introduction = '/intro';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const articleDetail = '/article/:id';
  static const profile = '/profile';
  static const explore = '/explore';
  static const trending = '/trending';
  static const saved = '/saved';
  static const myArticles = '/my-articles';
  static const createArticle = '/create-article';
  static const editArticle = '/edit-article/:id';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
