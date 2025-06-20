// lib/src/views/homepage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/views/main_wrapper.dart'; // Impor untuk GlobalKey
import 'package:app_9news/src/widgets/news_cards.dart'; // Impor untuk widget card

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchHomepageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          if (provider.isHomepageLoading && provider.latestArticles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () => provider.fetchHomepageData(),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              children: [
                _buildSearchField(context),
                const SizedBox(height: 24),
                if (provider.trendingArticles.isNotEmpty)
                  _buildTrendingCarousel(context, provider.trendingArticles),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Berita Terbaru",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 16),
                _buildLatestNewsList(provider.latestArticles),
                if (provider.latestArticles.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                    child: OutlinedButton(
                      onPressed: () => mainWrapperKey.currentState?.goToTab(1),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        foregroundColor: Theme.of(context).primaryColor,
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      child:
                          const Text("Lihat Semua Berita di Halaman Jelajah"),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}

// Widget Helper
Widget _buildSearchField(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () => mainWrapperKey.currentState?.goToTab(1),
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari berita atau topik...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
      ),
    );

Widget _buildTrendingCarousel(
    BuildContext context, List<NewsArticle> articles) {
  final newsProvider = Provider.of<NewsProvider>(context, listen: false);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text("Trending",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      const SizedBox(height: 16),
      CarouselSlider.builder(
        itemCount: articles.length,
        itemBuilder: (context, index, realIndex) =>
            TrendingNewsCard(article: articles[index]),
        options: CarouselOptions(
            height: 220,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85),
      ),
    ],
  );
}

Widget _buildLatestNewsList(List<NewsArticle> articles) => ListView.builder(
      itemCount: articles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemBuilder: (context, index) => LatestNewsCard(article: articles[index]),
    );
