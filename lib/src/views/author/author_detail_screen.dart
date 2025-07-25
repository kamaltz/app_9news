import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/widgets/news_cards.dart'; // <-- PERBAIKI IMPOR INI

class AuthorDetailScreen extends StatefulWidget {
  final Author author;
  const AuthorDetailScreen({super.key, required this.author});

  @override
  State<AuthorDetailScreen> createState() => _AuthorDetailScreenState();
}

class _AuthorDetailScreenState extends State<AuthorDetailScreen> {
  late Future<void> _fetchArticlesFuture;

  @override
  void initState() {
    super.initState();
    // Panggil metode publik dari provider
    _fetchArticlesFuture = Provider.of<NewsProvider>(context, listen: false)
        .fetchExploreArticles(query: widget.author.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Penulis"),
      ),
      body: ListView(
        children: [
          _buildProfileHeader(context, widget.author),
          const Divider(height: 32),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Artikel oleh ${widget.author.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
            future: _fetchArticlesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Consumer<NewsProvider>(
                builder: (context, provider, child) {
                  if (provider.isExploreLoading &&
                      provider.exploreArticles.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.exploreArticles.isEmpty) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Penulis ini belum memiliki artikel."),
                    ));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.exploreArticles.length,
                    // Pemanggilan LatestNewsCard sekarang sudah benar
                    itemBuilder: (context, index) => LatestNewsCard(
                        article: provider.exploreArticles[index]),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Author author) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(author.avatar),
            onBackgroundImageError: (exception, stackTrace) {},
          ),
          const SizedBox(height: 16),
          Text(author.name,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(author.title,
              style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
