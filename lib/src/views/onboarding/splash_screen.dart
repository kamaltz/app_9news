import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // <-- TAMBAHKAN IMPORT INI

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar untuk perhitungan responsif
    final screenHeight = MediaQuery.of(context).size.height;

    // Menjadwalkan navigasi otomatis setelah beberapa detik
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.introduction1);
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 150.h), // Responsif tinggi
              Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/zkr1nait25m0/Logo.png',
                height: 80.h, // Responsif tinggi
                fit: BoxFit.cover,
              ),
              SizedBox(height: 24.h), // Responsif tinggi
              Text(
                'Selamat Datang',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp, // Responsif ukuran font
                ),
              ),
              SizedBox(height: 12.h), // Responsif tinggi
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ), // Responsif lebar
                child: Text(
                  'Sumber berita terpercaya dari seluruh dunia secara aktual',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp, // Responsif ukuran font
                  ),
                ),
              ),
              SizedBox(height: 50.h), // Responsif tinggi
              Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/4pt5hbqcnibz/Dual_Ring%401x-1.5s-200px-200px_(1).gif',
                height: 50.h, // Responsif tinggi
                width: 50.w, // Responsif lebar
              ),
              const Spacer(), // Gunakan Spacer untuk mendorong ke bawah
              SizedBox(
                width: 200.w, // Responsif lebar
                height: 50.h, // Responsif tinggi
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.introduction1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.r,
                      ), // Responsif radius
                    ),
                  ),
                  child: Text(
                    'Mulai',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp, // Responsif ukuran font
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.1), // Spasi bawah
            ],
          ),
        ),
      ),
    );
  }
}
