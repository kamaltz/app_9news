// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/src/pages/home_page.dart';
import 'package:news_app/src/models/news_model.dart';
import 'package:go_router/go_router.dart'; // Untuk navigasi
import 'package:intl/intl.dart'; // Untuk format tanggal
// lib/services/news_api_service.dart (Contoh struktur)
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/api_config.dart'; // Asumsi base URL ada di sini

class NewsApiService {
  final String _baseUrl = ApiConfig.baseUrl;

  Future<List<NewsArticle>> getNews() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/news')); // Sesuaikan endpoint
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(
          response.body)['data']; // Sesuaikan dengan struktur response API
      return body
          .map((dynamic item) =>
              NewsArticle.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<NewsArticle> getNewsDetail(String id) async {
    // Implementasi untuk mengambil detail berita
    final response = await http.get(Uri.parse('$_baseUrl/news/$id'));
    if (response.statusCode == 200) {
      return NewsArticle.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load news detail');
    }
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    // Implementasi untuk pencarian berita
    final response = await http
        .get(Uri.parse('$_baseUrl/news/search?q=$query')); // Sesuaikan endpoint
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      return body
          .map((dynamic item) =>
              NewsArticle.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to search news');
    }
  }

  Future<bool> addArticle(String title, String content,
      String category /*, File imageFile */) async {
    // Implementasi untuk menambah artikel
    // Anda mungkin perlu menggunakan multipart request jika ada upload gambar
    final response = await http.post(
      Uri.parse('$_baseUrl/news'), // Sesuaikan endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-UTF-8',
        // 'Authorization': 'Bearer YOUR_AUTH_TOKEN', // Jika diperlukan
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'content': content,
        'category': category,
      }),
    );
    return response.statusCode == 201; // Created
  }

  Future<List<NewsArticle>> getMyArticles() async {
    // Implementasi untuk mengambil artikel yang diupload penulis
    // final response = await http.get(Uri.parse('$_baseUrl/users/me/articles'), headers: {'Authorization': 'Bearer YOUR_AUTH_TOKEN'});
    // ... (mirip getNews)
    throw UnimplementedError();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Panggil fetchNewsList saat halaman pertama kali dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchNewsList();
    });

    // Listener untuk pagination (infinite scroll)
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        if (newsProvider.pagination?.hasMore ?? false) {
          newsProvider.fetchNewsList(page: (newsProvider.pagination!.page) + 1);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Tanggal tidak diketahui';
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy, HH:mm', 'id_ID').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Terkini'),
        // Anda bisa menambahkan filter kategori atau tombol pencarian di sini
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.newsListState == NewsListState.loading &&
              newsProvider.newsList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (newsProvider.newsListState == NewsListState.error &&
              newsProvider.newsList.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Gagal memuat berita: ${newsProvider.errorMessage}',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => newsProvider.fetchNewsList(),
                      child: const Text('Coba Lagi'),
                    )
                  ],
                ),
              ),
            );
          } else if (newsProvider.newsList.isEmpty) {
            return const Center(
                child: Text('Tidak ada berita untuk ditampilkan.'));
          }

          return RefreshIndicator(
            onRefresh: () => newsProvider.fetchNewsList(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: newsProvider.newsList.length +
                  (newsProvider.pagination?.hasMore ?? false ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == newsProvider.newsList.length &&
                    (newsProvider.pagination?.hasMore ?? false)) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (index >= newsProvider.newsList.length)
                  return const SizedBox.shrink();

                final article = newsProvider.newsList[index];
                return _buildNewsCard(context, article);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, NewsArticle article) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior:
          Clip.antiAlias, // Untuk memastikan gambar ter-clip dengan baik
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman detail artikel, pastikan rute dan parameter sesuai
          if (article.id != null) {
            context.go('/article/${article.id}');
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null && article.imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: article.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator())),
                errorWidget: (context, url, error) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image,
                        size: 40, color: Colors.grey)),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${article.author.name} • ${_formatDate(article.publishedAt)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (article.category != null &&
                      article.category.isNotEmpty) ...[
                    const SizedBox(height: 8.0),
                    Chip(
                      label: Text(article.category,
                          style: const TextStyle(fontSize: 10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 0),
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      labelStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
