// lib/src/views/create_edit_article_screen.dart

import 'package:flutter/material.dart';

class CreateEditArticleScreen extends StatelessWidget {
  final String? articleId;
  final Map<String, dynamic>? initialData;

  const CreateEditArticleScreen({super.key, this.articleId, this.initialData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articleId == null ? 'Buat Artikel Baru' : 'Edit Artikel'),
      ),
      body: const Center(
        child: Text('Halaman Buat/Edit Artikel (akan datang)'),
      ),
    );
  }
}
