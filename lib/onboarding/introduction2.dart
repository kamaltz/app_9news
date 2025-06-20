// lib/src/views/onboarding/introduction2.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/configs/app_routes.dart'; // Impor AppRoutes
// Pastikan jalur ini benar

class Introduction2 extends StatelessWidget {
  const Introduction2({super.key});

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
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/m8q8h70o95c6/introduction2.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                Text(
                  'Pilih Minat Anda',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Personalisasikan pengalaman berita Anda dengan memilih topik yang paling relevan bagi Anda.',
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
                      // Ganti Introduction3.routeName dengan AppRoutes.introduction3
                      Navigator.pushNamed(context, AppRoutes.introduction3);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Lanjut',
                      style: GoogleFonts.interTight(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Ganti Introduction3.routeName dengan AppRoutes.introduction3
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
