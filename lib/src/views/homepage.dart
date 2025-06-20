import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/models/news_model.dart';
import 'package:app_9news/src/configs/app_routes.dart';

// Import halaman-halaman lain
import 'package:app_9news/src/views/explore/explore_screen.dart';
import 'package:app_9news/src/views/bookmarks/bookmarks_screen.dart';
import 'package:app_9news/src/views/profile/profile_screen.dart';

// Kunci global untuk mengakses state MainWrapper dari luar
final mainWrapperKey = GlobalKey<_MainWrapperState>();

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    ExploreScreen(),
    BookmarksScreen(),
    ProfileScreen(),
  ];

  void goToTab(int index) {
    if (_selectedIndex == index) return;

    if (index == 1)
      Provider.of<NewsProvider>(context, listen: false).fetchExploreArticles();
    if (index == 2)
      Provider.of<NewsProvider>(context, listen: false)
          .fetchBookmarkedArticles();
    if (index == 3)
      Provider.of<NewsProvider>(context, listen: false).fetchUserArticles();

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainWrapperKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Image.asset('assets/images/Logo.png',
            height: 40, fit: BoxFit.contain),
        centerTitle: false,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Jelajah'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              activeIcon: Icon(Icons.bookmark),
              label: 'Tersimpan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: goToTab,
      ),
    );
  }
}

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
                  child: _buildSectionHeader('Berita Terbaru', () {
                    mainWrapperKey.currentState?.goToTab(1);
                  }),
                ),
                const SizedBox(height: 16),
                _buildLatestNewsList(provider.latestArticles),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- WIDGET HELPER DI LUAR KELAS ---

Widget _buildSearchField(BuildContext context) {
  return Padding(
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
}

Widget _buildTrendingCarousel(
    BuildContext context, List<NewsArticle> articles) {
  final newsProvider = Provider.of<NewsProvider>(context, listen: false);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _buildSectionHeader('Trending', () {
          mainWrapperKey.currentState?.goToTab(1);
          newsProvider.selectCategory("Trending");
        }),
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

Widget _buildSectionHeader(String title, VoidCallback onViewAll) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        TextButton(onPressed: onViewAll, child: const Text('Lihat Semua')),
      ],
    );

Widget _buildLatestNewsList(List<NewsArticle> articles) => ListView.builder(
      itemCount: articles.length > 10 ? 10 : articles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemBuilder: (context, index) => LatestNewsCard(article: articles[index]),
    );

// --- WIDGET CARD YANG BISA DIGUNAKAN KEMBALI ---

class TrendingNewsCard extends StatelessWidget {
  final NewsArticle article;
  const TrendingNewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.newsDetail,
          arguments: article.id),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              article.imageUrl,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.category,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 4),
                Text(article.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LatestNewsCard extends StatelessWidget {
  final NewsArticle article;
  const LatestNewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.newsDetail,
          arguments: article.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
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
                  Text(article.category,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(article.title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(article.author.avatar),
                          radius: 10),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(article.author.name,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                              overflow: TextOverflow.ellipsis)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
