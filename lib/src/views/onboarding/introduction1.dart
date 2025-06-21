import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ini
import 'package:app_9news/src/configs/app_routes.dart';

class Introduction1 extends StatelessWidget {
  const Introduction1({super.key});

  static const String routeName = 'introduction1';
  static const String routePath = '/introduction1';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // isMobile check mungkin masih berguna untuk penyesuaian tata letak yang lebih kompleks,
    // tetapi untuk padding sederhana, .w sudah mencukupi.
    // final isMobile = MediaQuery.of(context).size.width < 600;

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
                  color: Color(0xFF5A4FCF),
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
                textAlign: TextAlign.justify,
                style: GoogleFonts.inter(
                  fontSize: 16.sp, // Responsif ukuran font
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tombol Skip
                  SizedBox(
                    width: 140.w,
                    height: 50.h,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF5A4FCF), width: 1.5),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'lewati',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A4FCF),
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w), // Jarak antar tombol
                  // Tombol 
                  SizedBox(
                    width: 140.w,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.introduction2);
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
            )
            // SizedBox(height: 20.h), // Opsional: padding paling bawah
          ],
        ),
      ),
    );
  }
}
