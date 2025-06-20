import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ini
import 'package:app_9news/src/configs/app_routes.dart';

class Introduction3 extends StatelessWidget {
  const Introduction3({super.key});

  static const String routeName = 'introduction3';
  static const String routePath = '/introduction3';

  Widget _featureCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: 288.6.w, // Responsif lebar
      height: 68.h, // Responsif tinggi
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r), // Responsif radius
      ),
      child: Row(
        children: [
          SizedBox(width: 20.w), // Responsif lebar
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 28.r,
          ), // Responsif ukuran ikon
          SizedBox(width: 20.w), // Responsif lebar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp, // Responsif ukuran font
                ),
              ),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 12.sp, // Responsif ukuran font
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h), // Responsif tinggi
                Padding(
                  padding: EdgeInsets.only(left: 30.w), // Responsif lebar
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/Logo.png',
                        width: 120.w, // Responsif lebar
                        height: 30.h, // Responsif tinggi
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h), // Responsif tinggi
                Image.asset(
                  'assets/images/introduction3.png',
                  width: 200.w, // Responsif lebar
                  height: 200.h, // Responsif tinggi
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.h), // Responsif tinggi
                Text(
                  'Selamat Datang di 9News',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp, // Responsif ukuran font
                  ),
                ),
                SizedBox(height: 10.h), // Responsif tinggi
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                  ), // Responsif lebar padding
                  child: Text(
                    'Gerbang pribadi Anda menuju berita terkini dan kisah yang sedang tren dari seluruh dunia, dirancang khusus untuk Anda.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp, // Responsif ukuran font
                    ),
                  ),
                ),
                SizedBox(height: 25.h), // Responsif tinggi
                _featureCard(
                  context: context,
                  icon: Icons.flash_on_outlined,
                  title: 'Berita Real Time',
                  description:
                      'Tetap update dengan notifikasi\nberita terkini secara instan.',
                ),
                SizedBox(height: 15.h), // Responsif tinggi
                _featureCard(
                  context: context,
                  icon: Icons.star,
                  title: 'Personalized Feed',
                  description:
                      'Cerita yang disesuaikan\n berdasarkan minat Anda.',
                ),
                SizedBox(height: 15.h), // Responsif tinggi
                _featureCard(
                  context: context,
                  icon: Icons.sort_by_alpha,
                  title: 'Cakupan Global',
                  description:
                      'Akses berita dari sumber\ntepercaya di seluruh dunia.',
                ),
                SizedBox(height: 20.h), // Responsif tinggi
                SizedBox(
                  width: 285.w, // Responsif lebar
                  height: 40.h, // Responsif tinggi
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
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
                      'Buka Segera',
                      style: GoogleFonts.interTight(
                        color: Colors.white,
                        fontSize: 18.sp, // Responsif ukuran font
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60.h), // Responsif tinggi
              ],
            ),
          ),
        ),
      ),
    );
  }
}
