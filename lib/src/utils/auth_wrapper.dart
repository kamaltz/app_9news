import 'package:flutter/material.dart';
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:app_9news/src/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;

  const AuthWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // PERBAIKAN: Ganti 'isAuthenticated' dengan 'isLoggedIn'
        if (!authProvider.isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
          return Container(); // Mengembalikan kontainer kosong saat navigasi
        }
        return child; // Mengembalikan child jika sudah login
      },
    );
  }
}
