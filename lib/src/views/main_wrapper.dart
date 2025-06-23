import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';

// Import semua halaman untuk Bottom Nav Bar
import 'package:app_9news/src/views/homepage.dart';
import 'package:app_9news/src/views/explore/explore_screen.dart';
import 'package:app_9news/src/views/bookmarks/bookmarks_screen.dart';
import 'package:app_9news/src/views/profile/profile_screen.dart';

// Kunci global untuk mengakses state MainWrapper dari luar (misal: dari homepage)
// Kunci ini akan menghubungkan tombol di homepage dengan fungsi pindah tab di sini.
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

  // Fungsi publik yang bisa dipanggil melalui GlobalKey untuk berpindah tab
  void goToTab(int index) {
    if (_selectedIndex == index) return; // Hindari build ulang jika tab sama

    // Muat data yang relevan sebelum berpindah tab
    if (index == 1) {
      Provider.of<NewsProvider>(context, listen: false).fetchExploreArticles();
    }
    if (index == 2) {
      Provider.of<NewsProvider>(context, listen: false)
          .fetchBookmarkedArticles();
    }
    if (index == 3) {
      Provider.of<NewsProvider>(context, listen: false).fetchUserArticles();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainWrapperKey, // Gunakan GlobalKey di sini
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Image.asset('assets/images/Logo.png',
            height: 40, fit: BoxFit.contain),
        centerTitle: false,
        actions: [
          if (_selectedIndex == 0) // Hanya tampilkan di tab Beranda
            IconButton(
              icon: const Icon(Icons.refresh, color: Color.fromARGB(255, 78, 70, 229),),
              onPressed: () {
                Provider.of<NewsProvider>(context, listen: false)
                    .fetchHomepageData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Memperbarui berita..."),
                      duration: Duration(seconds: 1)),
                );
              },
              tooltip: 'Perbarui Berita',
            ),
        ],
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
        selectedItemColor: Color.fromARGB(255, 78, 70, 229),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: goToTab, // Panggil fungsi goToTab saat tab ditekan
      ),
    );
  }
}
