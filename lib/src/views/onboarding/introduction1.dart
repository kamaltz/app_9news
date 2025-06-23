// lib/src/views/onboarding/introduction1.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // <-- TAMBAHKAN IMPORT INI

class Introduction1 extends StatelessWidget {
  const Introduction1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Definisikan theme di sini

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.h), // Responsif tinggi
            Image.network(
              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/xrvwhqxnuxh9/introduction1.png',
              width: 323.8.w, // Responsif lebar
              height: 302.27.h, // Responsif tinggi
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10.h), // Responsif tinggi
            Padding(
              // Gunakan .w untuk padding horizontal
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                'Jangan sampai ketinggalan berita di mana pun!',
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
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Text(
                'Dapatkan pemberitahuan langsung untuk berita terkini dan berita yang sedang tren, di mana pun Anda berada. 9News memberikan informasi yang Anda butuhkan.',
                textAlign: TextAlign
                    .center, // Ubah ke center agar lebih rapih untuk intro
                style: GoogleFonts.inter(
                  fontSize: 16.sp, // Responsif ukuran font
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20.h,
              ), // Responsif tinggi padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
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
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme
                            .primary, // Ganti menjadi theme.colorScheme.primary
                        fontSize: 14.sp, // Responsif ukuran font
                      ),
                    ),
                  ),
                  SizedBox(width: 150.w), // Responsif lebar
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.introduction2);
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
    );
  }
}
