import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  static const String routeName = 'newslist';
  static const String routePath = '/newslist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Latest News',
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
              'This is the News List Page',
              style: GoogleFonts.inter(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'List of news articles will be displayed here.',
              style: GoogleFonts.inter(),
            ),
            // You would typically fetch and display news items here
          ],
        ),
      ),
    );
  }
}
