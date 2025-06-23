// lib/src/views/bookmarks/bookmarks_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/widgets/news_cards.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  final Color primaryColor = const Color.fromARGB(255, 78, 70, 234);

  // Widget untuk tampilan saat daftar bookmark kosong
  // Dibuat lebih menarik secara visual
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.collections_bookmark_outlined,
              size: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            Text(
              'Belum Ada Artikel',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Simpan artikel yang Anda suka dengan menekan ikon bookmark, dan semua akan muncul di sini.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Artikel Tersimpan', // Judul halaman yang kita diskusikan
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          // Tampilkan indikator loading saat data sedang diambil
          if (provider.isBookmarkLoading) {
            return Center(child: CircularProgressIndicator(color: primaryColor));
          }

          // Tampilkan halaman "kosong" jika tidak ada artikel
          if (provider.bookmarkedArticles.isEmpty) {
            return _buildEmptyState();
          }

          // Tampilkan daftar artikel jika ada
          return RefreshIndicator(
            onRefresh: () => provider.fetchBookmarkedArticles(),
            color: primaryColor,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemCount: provider.bookmarkedArticles.length,
              // Memberikan garis pemisah antar kartu
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[200],
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              itemBuilder: (context, index) {
                final article = provider.bookmarkedArticles[index];
                // Menggunakan kembali LatestNewsCard yang sudah ada
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: LatestNewsCard(article: article),
                );
              },
            ),
          );
        },
      ),
    );
  }
}