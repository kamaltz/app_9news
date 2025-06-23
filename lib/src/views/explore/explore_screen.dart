// lib/src/views/explore/explore_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
// Impor untuk Lates
import 'package:app_9news/src/widgets/news_cards.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Muat berita dengan kategori yang mungkin sudah dipilih
      Provider.of<NewsProvider>(context, listen: false).fetchExploreArticles();
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
      backgroundColor: Colors.grey[100],
      body: Consumer<NewsProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari berita...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                  onSubmitted: (value) =>
                      provider.fetchExploreArticles(query: value),
                ),
              ),
              // Slider Kategori
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = provider.categories[index];
                    return ChoiceChip(
                      label: Text(category),
                      selected: provider.selectedCategory == category,
                      onSelected: (selected) {
                        provider.selectCategory(category);
                      },
                      backgroundColor: Colors.white,
                      selectedColor:
                          Color.fromARGB(255, 78, 70, 234), 
                      labelStyle: TextStyle(
                          color: provider.selectedCategory == category
                              ? Colors.white
                              : Colors.black),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Hasil Berita
              Expanded(
                child: provider.isExploreLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.exploreError != null
                        ? Center(child: Text('Error: ${provider.exploreError}'))
                        : provider.exploreArticles.isEmpty
                            ? const Center(
                                child: Text('Tidak ada berita yang ditemukan.'))
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: provider.exploreArticles.length,
                                itemBuilder: (context, index) {
                                  final article =
                                      provider.exploreArticles[index];
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
