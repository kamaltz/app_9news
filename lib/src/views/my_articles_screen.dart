// lib/src/views/my_articles_screen.dart

import 'package:flutter/material.dart';

class MyArticlesScreen extends StatelessWidget {
  const MyArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artikel Saya')),
      body: const Center(child: Text('Halaman Artikel Saya (akan datang)')),
    );
  }
}
