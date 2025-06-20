// lib/src/views/homepage.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// --- MAIN WRAPPER DENGAN BOTTOM NAV BAR ---
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomepageWidget(),
    Center(child: Text('Halaman Explore')), // Placeholder
    Center(child: Text('Halaman Tersimpan')), // Placeholder
    Center(child: Text('Halaman Profil')), // Placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Image.network(
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/zkr1nait25m0/Logo.png',
          height: 25, // Sesuaikan tinggi logo
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              // Aksi notifikasi
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: 'Tersimpan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

// --- HOMEPAGE WIDGET ---
class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  final _searchController = TextEditingController();
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Panggil provider untuk mengambil data saat halaman pertama kali dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchHomepageData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.latestArticles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null &&
              provider.latestArticles.isEmpty) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchHomepageData(),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // 1. Text Field Pencarian
                _buildSearchField(provider),
                const SizedBox(height: 24),

                // 2. Berita Trending (PageView)
                if (provider.trendingArticles.isNotEmpty)
                  _buildTrendingSection(provider.trendingArticles),
                const SizedBox(height: 24),

                // 3. Judul Berita Terbaru
                _buildSectionHeader('Berita Terbaru', () {
                  // Aksi 'Lihat Semua'
                }),
                const SizedBox(height: 16),

                // 4. Daftar Berita Terbaru (Card)
                _buildLatestNewsList(provider.latestArticles),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchField(NewsProvider provider) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Cari berita...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onSubmitted: (value) {
        provider.searchArticles(value);
      },
    );
  }

  Widget _buildTrendingSection(List<NewsArticle> trendingArticles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Trending', () {}),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: trendingArticles.length > 5
                ? 5
                : trendingArticles.length,
            itemBuilder: (context, index) {
              final article = trendingArticles[index];
              return TrendingNewsCard(article: article);
            },
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: trendingArticles.length > 5 ? 5 : trendingArticles.length,
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.blue[800]!,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: onViewAll, child: const Text('Lihat Semua')),
      ],
    );
  }

  Widget _buildLatestNewsList(List<NewsArticle> latestArticles) {
    return ListView.builder(
      itemCount: latestArticles.length > 10 ? 10 : latestArticles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final article = latestArticles[index];
        return LatestNewsCard(article: article);
      },
    );
  }
}

// --- CARD UNTUK BERITA TRENDING ---
class TrendingNewsCard extends StatelessWidget {
  final NewsArticle article;
  const TrendingNewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          // Gambar Background
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              article.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
          ),
          // Teks di atas gambar
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.author.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  article.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- CARD UNTUK BERITA TERBARU ---
class LatestNewsCard extends StatelessWidget {
  final NewsArticle article;
  const LatestNewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              article.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.category,
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(article.author.avatar),
                      radius: 12,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        article.author.name,
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.remove_red_eye_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      article.readTime,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
