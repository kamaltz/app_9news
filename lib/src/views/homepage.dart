// views/homepage.dart (TOMBOL JELAJAHI SUDAH DIPERBARUI)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/views/main_wrapper.dart';
import 'package:app_9news/src/widgets/news_cards.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _searchController = TextEditingController();
  final Color primaryColor = const Color.fromARGB(255, 78, 70, 234);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchHomepageData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          if (provider.isHomepageLoading && provider.latestArticles.isEmpty) {
            return Center(child: CircularProgressIndicator(color: primaryColor));
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchHomepageData(),
            color: primaryColor,
            child: CustomScrollView(
              slivers: [
                _buildSliverAppBar(),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 24),
                    if (provider.trendingArticles.isNotEmpty)
                      _buildTrendingCarousel(context, provider.trendingArticles),
                    const SizedBox(height: 24),
                    _buildSectionHeader("Berita Terbaru"),
                    const SizedBox(height: 16),
                    _buildLatestNewsList(provider.latestArticles),
                    if (provider.latestArticles.isNotEmpty)
                      // Ini adalah tombol yang kita ubah gayanya
                      _buildViewAllButton(context),
                    const SizedBox(height: 20),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      floating: true,
      elevation: 0.5,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: _buildSearchField(context),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Cari topik, berita, atau penulis...',
          hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: (query) {
          if (query.trim().isNotEmpty) {
            newsProvider.fetchExploreArticles(query: query);
            _searchController.clear();
            mainWrapperKey.currentState?.goToTab(1);
          }
        },
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTrendingCarousel(BuildContext context, List<NewsArticle> articles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Lagi Trending"),
        const SizedBox(height: 16),
        CarouselSlider.builder(
          itemCount: articles.length,
          itemBuilder: (context, index, realIndex) => TrendingNewsCard(article: articles[index]),
          options: CarouselOptions(
            height: 230,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            autoPlayInterval: const Duration(seconds: 4),
          ),
        ),
      ],
    );
  }

  Widget _buildLatestNewsList(List<NewsArticle> articles) {
    return ListView.separated(
      itemCount: articles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      separatorBuilder: (context, index) => const Divider(indent: 16, endIndent: 16),
      itemBuilder: (context, index) => LatestNewsCard(article: articles[index]),
    );
  }
  
  // --- PERUBAHAN DI SINI: Gaya Tombol Menuju Halaman Jelajahi ---
  Widget _buildViewAllButton(BuildContext context) {
    return Padding(
      // Atur padding agar ada jarak yang pas
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: OutlinedButton.icon(
        icon: const Icon(Icons.explore_outlined),
        label: Text(
          "Jelajahi Semua Berita di exploler",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            fontSize: 15, // Sedikit sesuaikan ukuran font
          ),
        ),
        onPressed: () => mainWrapperKey.currentState?.goToTab(1),
        style: OutlinedButton.styleFrom(
          // Warna teks dan ikon adalah warna primer
          foregroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 52),
          // Bentuk tombol dengan sudut membulat
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // Garis tepi tombol menggunakan warna primer
          side: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
    );
  }
} 