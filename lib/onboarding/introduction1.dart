// lib/src/views/onboarding/introduction1.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/configs/app_routes.dart'; // Impor AppRoutes
// Impor berkas onboarding lainnya dari jalur yang benar
// Pastikan jalur ini benar
// Pastikan jalur ini benar

class Introduction1 extends StatelessWidget {
  const Introduction1({super.key});

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
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/70f3f262r00l/introduction1.png',
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
                const SizedBox(height: 100),
                SizedBox(
                  width: 285,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      // Ganti introduction2.routeName dengan AppRoutes.introduction2
                      Navigator.pushNamed(context, AppRoutes.introduction2);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Selanjutnya',
                      style: GoogleFonts.interTight(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Ganti introduction3.routeName dengan AppRoutes.introduction3
                    Navigator.pushNamed(context, AppRoutes.introduction3);
                  },
                  child: Text(
                    'Lewati',
                    style: GoogleFonts.interTight(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
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
