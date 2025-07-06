// lib/src/views/news/news_detail_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/controller/news_service.dart';
import 'package:app_9news/src/views/author/author_detail_screen.dart'; // Impor halaman detail penulis

class NewsDetailPage extends StatefulWidget {
  final String newsId;
  const NewsDetailPage({super.key, required this.newsId});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  // Gunakan Future untuk mengambil data artikel
  late Future<NewsArticle> _articleFuture;
  bool _isBookmarked = false;
  bool _isLoadingBookmarkStatus = true;

  @override
  void initState() {
    super.initState();
    // Panggil service untuk mengambil detail artikel berdasarkan ID
    _articleFuture = NewsService().fetchArticleById(widget.newsId);
    _checkBookmarkStatus();
  }

  // Fungsi untuk memeriksa status bookmark saat halaman dibuka
  void _checkBookmarkStatus() async {
    // Set state loading
    if (mounted) setState(() => _isLoadingBookmarkStatus = true);
    try {
      final status = await NewsService().checkBookmarkStatus(widget.newsId);
      if (mounted) {
        setState(() {
          _isBookmarked = status;
        });
      }
    } catch (e) {
      // Gagal memeriksa status, bisa karena belum login atau error lain.
      // Biarkan status bookmark menjadi false.
    } finally {
      if (mounted) {
        setState(() => _isLoadingBookmarkStatus = false);
      }
    }
  }

  // Fungsi yang dipanggil saat tombol bookmark ditekan
  void _onBookmarkPressed() async {
    try {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      // Panggil fungsi toggleBookmark dari provider dan tunggu hasilnya
      final success = await newsProvider.toggleBookmark(widget.newsId);
      
      if (success && mounted) {
        // Update UI hanya jika operasi berhasil
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
        
        // Tampilkan notifikasi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isBookmarked
                ? "Artikel disimpan ke bookmark"
                : "Bookmark dihapus"),
            duration: const Duration(seconds: 2),
          ),
        );
      } else if (mounted) {
        // Tampilkan pesan error jika gagal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal mengubah status bookmark. Pastikan Anda sudah login."),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<NewsArticle>(
        future: _articleFuture,
        builder: (context, snapshot) {
          // Tampilkan loading indicator saat data sedang diambil
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Tampilkan pesan error jika terjadi kesalahan
          if (snapshot.hasError) {
            return Center(
                child: Text("Error memuat artikel: ${snapshot.error}"));
          }
          // Tampilkan pesan jika data tidak ditemukan
          if (!snapshot.hasData) {
            return const Center(child: Text("Artikel tidak ditemukan."));
          }

          // Jika data berhasil didapat, bangun UI
          final article = snapshot.data!;

          return CustomScrollView(
            slivers: [
              // AppBar yang bisa membesar/mengecil dengan gambar
              _buildSliverAppBar(article),
              // Konten utama artikel
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.3),
                      ),
                      const SizedBox(height: 16),
                      // Info penulis yang dapat ditekan
                      _buildAuthorInfo(context, article.author,
                          article.publishedAt, article.readTime),
                      const Divider(height: 32),
                      // Konten artikel
                      Text(
                        article.content,
                        style: const TextStyle(
                            fontSize: 16, height: 1.7, color: Colors.black87),
                      ),
                      const Divider(height: 32),
                      // Tampilkan Tags jika ada
                      if (article.tags.isNotEmpty) _buildTags(article.tags),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Widget untuk AppBar dengan gambar
  Widget _buildSliverAppBar(NewsArticle article) {
    return SliverAppBar(
      expandedHeight: 280.0,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              article.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, color: Colors.white)),
            ),
            // Gradient overlay agar teks lebih mudah dibaca
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: <Color>[Colors.black54, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Tombol Bookmark di pojok kanan atas
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _isLoadingBookmarkStatus
              ? const Center(
                  child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)))
              : IconButton(
                  icon: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      size: 28),
                  onPressed: _onBookmarkPressed,
                  tooltip: 'Simpan Bookmark',
                ),
        ),
      ],
    );
  }

  // Widget untuk info penulis yang dapat ditekan
  Widget _buildAuthorInfo(BuildContext context, Author author,
      String publishedAt, String readTime) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail penulis
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthorDetailScreen(author: author),
            ));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(author.avatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 2),
                Text(
                  "$publishedAt • $readTime baca",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan daftar tags
  Widget _buildTags(List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tags Terkait",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: tags
              .map((tag) => Chip(
                    label: Text(tag),
                    backgroundColor: Colors.grey[200],
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
