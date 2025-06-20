// lib/src/views/news/news_detail_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/controller/news_service.dart';

class NewsDetailPage extends StatefulWidget {
  final String newsId;
  const NewsDetailPage({super.key, required this.newsId});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late Future<NewsArticle> _articleFuture;
  bool _isBookmarked = false;
  bool _isLoadingBookmarkStatus = true;

  @override
  void initState() {
    super.initState();
    _articleFuture = NewsService().fetchArticleById(widget.newsId);
    _checkBookmarkStatus();
  }

  void _checkBookmarkStatus() async {
    setState(() => _isLoadingBookmarkStatus = true);
    try {
      final status = await NewsService().checkBookmarkStatus(widget.newsId);
      if (mounted) {
        setState(() {
          _isBookmarked = status;
        });
      }
    } catch (e) {
      // Gagal memeriksa status, mungkin karena belum login
    } finally {
      if (mounted) {
        setState(() => _isLoadingBookmarkStatus = false);
      }
    }
  }

  void _onBookmarkPressed() {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.toggleBookmark(widget.newsId);
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isBookmarked ? "Artikel disimpan" : "Bookmark dihapus"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<NewsArticle>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text("Error memuat artikel: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Artikel tidak ditemukan."));
          }

          final article = snapshot.data!;

          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(article),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul
                      Text(
                        article.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      // Info Penulis dan Tanggal
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(article.author.avatar),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article.author.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(
                                "${article.publishedAt} • ${article.readTime} baca",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      // Konten Artikel
                      Text(
                        article.content,
                        style: const TextStyle(
                            fontSize: 16, height: 1.6, color: Colors.black87),
                      ),
                      const Divider(height: 32),
                      // Tags
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

  Widget _buildSliverAppBar(NewsArticle article) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Image.network(
          article.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey,
              child: const Icon(Icons.broken_image, color: Colors.white)),
        ),
        titlePadding: const EdgeInsets.only(left: 60, bottom: 16),
        title: Text(
          article.category,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 5)]),
        ),
      ),
      actions: [
        // Tombol Bookmark
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _isLoadingBookmarkStatus
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ))
              : IconButton(
                  icon: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border),
                  onPressed: _onBookmarkPressed,
                ),
        ),
      ],
    );
  }

  Widget _buildTags(List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tags",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: tags.map((tag) => Chip(label: Text(tag))).toList(),
        ),
      ],
    );
  }
}
