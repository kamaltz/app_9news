import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:app_9news/src/views/homepage.dart'; // Impor LatestNewsCard

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          if (provider.isBookmarkLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.bookmarkedArticles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_remove_outlined,
                      size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('Anda belum menyimpan artikel.',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            );
          }

          // API sudah otomatis memfilter bookmark berdasarkan user yang login
          // jadi kita bisa langsung tampilkan hasilnya.
          return RefreshIndicator(
            onRefresh: () => provider.fetchBookmarkedArticles(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: provider.bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = provider.bookmarkedArticles[index];
                // Kita gunakan kembali LatestNewsCard yang sudah ada
                return LatestNewsCard(article: article);
              },
            ),
          );
        },
      ),
    );
  }
}
