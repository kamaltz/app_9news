// lib/onboarding/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Import AppRoutes untuk menggunakan nama rute yang benar
import 'package:app_9news/src/configs/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: InkWell(
            onTap: () {
              // --- PERBAIKAN DI SINI ---
              // Ganti Introduction1.routeName menjadi AppRoutes.introduction1
              Navigator.pushNamed(context, AppRoutes.introduction1);
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 150),
                Image.network(
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/zkr1nait25m0/Logo.png',
                  height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 24),
                Text(
                  'Selamat Datang',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Sumber berita terpercaya dari seluruh dunia secara aktual',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Image.network(
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/4pt5hbqcnibz/Dual_Ring%401x-1.5s-200px-200px_(1).gif',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
