// lib/src/views/onboarding/introduction2.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // <-- TAMBAHKAN IMPORT INI

class Introduction2 extends StatelessWidget {
  const Introduction2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Definisikan theme di sini

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 90.h), // Responsif tinggi
              Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/4awnqdgpe17m/introduction2.png',
                width: 323.8.w, // Responsif lebar
                height: 302.27.h, // Responsif tinggi
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30.h), // Responsif tinggi
              Padding(
                padding: EdgeInsets.only(right: 30.w), // Responsif lebar
                child: Text(
                  'Informasi yang Dapat Diandalkan',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme
                        .primary, // Ganti menjadi theme.colorScheme.primary
                    fontSize: 20.sp, // Responsif ukuran font
                  ),
                ),
              ),
              SizedBox(height: 10.h), // Responsif tinggi
              Padding(
                // Gunakan .w untuk padding horizontal
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Akses berita terverifikasi dari sumber tepercaya. Sistem pengecekan fakta kami memastikan Anda menerima informasi akurat selama peristiwa penting.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp, // Responsif ukuran font
                  ),
                ),
              ),
              SizedBox(height: 50.h), // Responsif tinggi
              Padding(
                padding: EdgeInsets.only(
                  bottom: 20.h,
                ), // Responsif tinggi padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.introduction3);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: theme.colorScheme
                                .primary), // Ganti menjadi theme.colorScheme.primary
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w, // Responsif lebar padding
                          vertical: 10.h, // Responsif tinggi padding
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.r,
                          ), // Responsif radius
                        ),
                      ),
                      child: Text(
                        'Lewati',
                        style: GoogleFonts.interTight(
                          color: theme.colorScheme
                              .primary, // Ganti menjadi theme.colorScheme.primary
                          fontSize: 14.sp, // Responsif ukuran font
                        ),
                      ),
                    ),
                    SizedBox(width: 170.w), // Responsif lebar
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.introduction3);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme
                            .primary, // Ganti menjadi theme.colorScheme.primary
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w, // Responsif lebar padding
                          vertical: 10.h, // Responsif tinggi padding
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10.r,
                          ), // Responsif radius
                        ),
                      ),
                      child: Text(
                        'Lanjutkan',
                        style: GoogleFonts.interTight(
                          color: Colors.white,
                          fontSize: 14.sp, // Responsif ukuran font
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
