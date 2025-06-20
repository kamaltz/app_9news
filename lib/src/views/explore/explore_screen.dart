// lib/src/views/explore/explore_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/views/homepage.dart'; // Impor untuk menggunakan LatestNewsCard

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    // Panggil pencarian awal (tanpa query/kategori) untuk menampilkan semua berita
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).searchArticles();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final provider = Provider.of<NewsProvider>(context, listen: false);
    provider.searchArticles(
      query: _searchController.text.trim(),
      category: _selectedCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Daftar kategori yang akan ditampilkan di filter
    final categories = [
      "Nasional",
      "Teknologi",
      "Bola",
      "Internasional",
      "Trending"
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Bagian atas: Pencarian dan Filter
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // 1. Text Field Pencarian
                    TextField(
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
                      onSubmitted: (value) => _performSearch(),
                    ),
                    const SizedBox(height: 16),
                    // 2. Filter Kategori
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return ChoiceChip(
                            label: Text(category),
                            selected: _selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedCategory = category;
                                } else {
                                  _selectedCategory =
                                      ''; // Hapus filter jika di-unselect
                                }
                              });
                              _performSearch();
                            },
                            backgroundColor: Colors.white,
                            selectedColor:
                                Theme.of(context).primaryColor.withOpacity(0.8),
                            labelStyle: TextStyle(
                              color: _selectedCategory == category
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.grey[300]!)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Bagian bawah: Daftar Hasil Berita
              Expanded(
                child: provider.isSearchLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.searchError != null
                        ? Center(child: Text('Error: ${provider.searchError}'))
                        : provider.searchedArticles.isEmpty
                            ? const Center(
                                child: Text('Tidak ada berita yang ditemukan.'))
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: provider.searchedArticles.length,
                                itemBuilder: (context, index) {
                                  final article =
                                      provider.searchedArticles[index];
                                  // Kita bisa menggunakan kembali widget card dari homepage
                                  return LatestNewsCard(article: article);
                                },
                              ),
              ),
            ],
          );
        },
      ),
    );
  }
}
