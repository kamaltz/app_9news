import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/views/onboarding/introduction3.dart';

class Introduction2 extends StatelessWidget {
  const Introduction2({super.key});

  static const String routeName = 'introduction2';
  static const String routePath = '/introduction2';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 90),
            Image.network(
              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/4awnqdgpe17m/introduction2.png',
              width: 323.8,
              height: 302.27,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                'Informasi yang Dapat Diandalkan',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 250),
              child: Text(
                'Akses berita terverifikasi dari sumber tepercaya. Sistem pengecekan fakta kami memastikan Anda menerima informasi akurat selama peristiwa penting.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.inter(),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Introduction3.routeName);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.primaryColor),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Lewati',
                      style: GoogleFonts.interTight(color: theme.primaryColor),
                    ),
                  ),
                  const SizedBox(width: 170),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Introduction3.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Lanjutkan',
                      style: GoogleFonts.interTight(color: Colors.white),
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
