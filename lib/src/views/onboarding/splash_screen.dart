import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Asumsi Anda menggunakan AppRoutes untuk navigasi ke introduction1
import 'package:app_9news/src/configs/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Anda dapat menyimpan nama rute di AppRoutes agar terpusat
  // static const String routeName = 'splashscreen';
  // static const String routePath = '/splashscreen';

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar untuk perhitungan responsif
    final screenHeight = MediaQuery.of(context).size.height;

    // Menjadwalkan navigasi otomatis setelah beberapa detik
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        // Menggunakan AppRoutes untuk navigasi yang aman
        Navigator.pushReplacementNamed(context, AppRoutes.introduction1);
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // Memastikan konten bisa di-scroll
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.15), // Spasi responsif
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
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Sumber berita terpercaya dari seluruh dunia secara aktual',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.08), // Spasi responsif
                Image.network(
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/4pt5hbqcnibz/Dual_Ring%401x-1.5s-200px-200px_(1).gif',
                  height: 80,
                  width: 80,
                ),
                SizedBox(height: screenHeight * 0.1), // Spasi bawah
              ],
            ),
          ),
        ),
      ),
    );
  }
}