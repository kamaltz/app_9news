import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ini
import 'package:app_9news/src/configs/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splashscreen';
  static const String routePath = '/splashscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 100.h), // Responsif tinggi
              Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/zkr1nait25m0/Logo.png',
                height: 120.h, // Responsif tinggi
                fit: BoxFit.cover,
              ),
              SizedBox(height: 25.h), // Responsif tinggi
              Text(
                'Selamat Datang',
                style: GoogleFonts.inter(
                  color: Color(0xFF5A4FCF),
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp, // Responsif ukuran font
                ),
              ),
              SizedBox(height: 10.h), // Responsif tinggi
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
              SizedBox(height: 90.h), // Responsif tinggi
              Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/4pt5hbqcnibz/Dual_Ring%401x-1.5s-200px-200px_(1).gif',
                height: 120.h, // Responsif tinggi
                width: 120.w, // Responsif lebar
              ),
              SizedBox(height: 60.h), // Responsif tinggi
              SizedBox(
                width: 150.w, // Responsif lebar
                height: 70.h, // Responsif tinggi
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.introduction1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5A4FCF),
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
              SizedBox(height: 20.h), // Responsif tinggi
            ],
          ),
        ),
      ),
    );
  }
}
