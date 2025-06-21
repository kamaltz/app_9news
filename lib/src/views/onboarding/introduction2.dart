import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ini
import 'package:app_9news/src/configs/app_routes.dart';

class Introduction2 extends StatelessWidget {
  const Introduction2({super.key});

  static const String routeName = 'introduction2';
  static const String routePath = '/introduction2';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // isMobile check mungkin masih berguna untuk penyesuaian tata letak yang lebih kompleks,
    // tetapi untuk padding sederhana, .w sudah mencukupi.
    // final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
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
                padding: EdgeInsets.only(right: 20.w), // Responsif lebar
                child: Text(
                  'Informasi yang Dapat Diandalkan',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5A4FCF),
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
              SizedBox(height: 90.h), // Responsif tinggi
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tombol Lewati
                    SizedBox(
                      width: 140.w,
                      height: 50.h,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.introduction3);
                        },
                        style: OutlinedButton.styleFrom(
                          side:
                              BorderSide(color: Color(0xFF5A4FCF), width: 1.5),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Lewati',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5A4FCF),
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 20.w), // Jarak antar tombol

                    // Tombol Lanjut
                    SizedBox(
                      width: 140.w,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.introduction3);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5A4FCF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Lanjutkan',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
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
