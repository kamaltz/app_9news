import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_9news/src/utils/preferences_util.dart'; // Import utility untuk preferences

class Introduction3 extends StatelessWidget {
  const Introduction3({super.key});

  Widget _featureCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(description, style: GoogleFonts.inter()),
                ],
              ),
            ),
          ],
        ),
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
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/Logo.png',
                        width: 120.w,
                        height: 30.h,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Image.asset(
                  'assets/images/introduction3.png',
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Selamat Datang di 9News',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                  ),
                  child: Text(
                    'Gerbang pribadi Anda menuju berita terkini dan kisah yang sedang tren dari seluruh dunia, dirancang khusus untuk Anda.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                _featureCard(
                  context: context,
                  icon: Icons.flash_on_outlined,
                  title: 'Berita Real Time',
                  description:
                      'Tetap update dengan notifikasi\nberita terkini secara instan.',
                ),
                SizedBox(height: 15.h),
                _featureCard(
                  context: context,
                  icon: Icons.star,
                  title: 'Personalized Feed',
                  description:
                      'Cerita yang disesuaikan\n berdasarkan minat Anda.',
                ),
                SizedBox(height: 15.h),
                _featureCard(
                  context: context,
                  icon: Icons.sort_by_alpha,
                  title: 'Cakupan Global',
                  description:
                      'Akses berita dari sumber\ntepercaya di seluruh dunia.',
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 285.w,
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Tandai bahwa pengguna sudah melihat onboarding
                      await PreferencesUtil.markOnboardingAsSeen();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.login, (route) => false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Buka Segera',
                      style: GoogleFonts.interTight(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
