import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Baris ini akan menjadi usang jika Anda menggunakan AppRoutes untuk navigasi.
// import 'package:app_9news/src/views/auth/login_screen.dart';

// Penting: Impor AppRoutes untuk mengakses nama rute yang benar
import 'package:app_9news/src/configs/app_routes.dart'; // <--- Tambahkan baris ini

// Asumsi Anda memiliki impor lain yang relevan seperti dari flutter_flow
// import 'package:app_9news/flutter_flow/flutter_flow_theme.dart';
// import 'package:app_9news/flutter_flow/flutter_flow_util.dart';
// import 'package:app_9news/flutter_flow/flutter_flow_widgets.dart';

class Introduction3 extends StatelessWidget {
  const Introduction3({super.key});

  // Nama rute statis ini mungkin tidak lagi diperlukan di sini jika Anda menggunakan AppRoutes sepenuhnya
  // static const String routeName = 'introduction3';
  // static const String routePath = '/introduction3';

  Widget _featureCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: 288.6,
      height: 68,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 28),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
              Text(description, style: GoogleFonts.inter()),
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Image.network(
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/zkr1nait25m0/Logo.png',
                        width: 120,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Image.network(
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/doy7c0x3ylpr/introduction3.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  'Selamat Datang di 9News',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Gerbang pribadi Anda menuju berita terkini dan kisah yang sedang tren dari seluruh dunia, dirancang khusus untuk Anda.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.inter(),
                  ),
                ),
                const SizedBox(height: 25),
                _featureCard(
                  context: context,
                  icon: Icons.flash_on_outlined,
                  title: 'Berita Real Time',
                  description:
                      'Tetap update dengan notifikasi\nberita terkini secara instan.',
                ),
                const SizedBox(height: 15),
                _featureCard(
                  context: context,
                  icon: Icons.star,
                  title: 'Personalized Feed',
                  description:
                      'Cerita yang disesuaikan\n berdasarkan minat Anda.',
                ),
                const SizedBox(height: 15),
                _featureCard(
                  context: context,
                  icon: Icons.sort_by_alpha,
                  title: 'Cakupan Global',
                  description:
                      'Akses berita dari sumber\ntepercaya di seluruh dunia.',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 285,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      // PERBAIKAN DI SINI: Gunakan AppRoutes.login
                      Navigator.pushNamed(
                        context,
                        AppRoutes.login,
                      ); // <--- Perubahan penting
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary, // Gunakan colorScheme
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Buka Segera',
                      style: GoogleFonts.interTight(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
