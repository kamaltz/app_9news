import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsId; // Example: to fetch specific news details

  const NewsDetailPage({super.key, required this.newsId});

  static const String routeName = 'newsdetail';
  static const String routePath = '/newsdetail/:newsId';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Details',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the News Detail Page for ID: $newsId',
              style: GoogleFonts.inter(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Full content of the news article will be shown here.',
              style: GoogleFonts.inter(),
            ),
            // You would fetch and display specific news content here using newsId
          ],
        ),
      ),
    );
  }
}
