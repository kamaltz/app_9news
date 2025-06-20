import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/oboarding/introduction2.dart';
import 'package:app_9news/oboarding/introduction3.dart';

class Introduction1 extends StatelessWidget {
  const Introduction1({super.key});

  static const String routeName = 'introduction1';
  static const String routePath = '/introduction1';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/xrvwhqxnuxh9/introduction1.png',
                width: 323.8,
                height: 302.27,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 25 : 250),
                child: Text(
                  'Jangan sampai ketinggalan berita di mana pun!',
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
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 25 : 250),
                child: Text(
                  'Dapatkan pemberitahuan langsung untuk berita terkini dan berita yang sedang tren, di mana pun Anda berada. 9News memberikan informasi yang Anda butuhkan.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.inter(),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 350),
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
                        style: GoogleFonts.interTight(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 150),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Introduction2.routeName);
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
      ),
    );
  }
}
