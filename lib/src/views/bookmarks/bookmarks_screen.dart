// lib/src/views/bookmarks/bookmarks_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/configs/app_routes.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    super.initState();
    // Memuat artikel yang di-bookmark saat halaman pertama kali dibuka
    // (Diasumsikan sudah dipanggil saat tab di-tap di MainWrapper)
  }

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
            return const Center(
              child: Text(
                'Anda belum menyimpan artikel apapun.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchBookmarkedArticles(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: provider.bookmarkedArticles.length,
              itemBuilder: (context, index) {
                final article = provider.bookmarkedArticles[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman detail berita
                    Navigator.pushNamed(
                      context,
                      AppRoutes.newsDetail,
                      arguments: article.id,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            article.imageUrl,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                    width: 90,
                                    height: 90,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.broken_image)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Oleh: ${article.author.name}",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        // Tombol untuk menghapus bookmark
                        IconButton(
                          icon: const Icon(Icons.bookmark,
                              color: Colors.redAccent),
                          onPressed: () {
                            // Panggil fungsi untuk menghapus bookmark
                            Provider.of<NewsProvider>(context, listen: false)
                                .toggleBookmark(article.id);

                            // Tampilkan notifikasi
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Bookmark dihapus."),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
