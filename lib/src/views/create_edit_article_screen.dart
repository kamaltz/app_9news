// lib/src/views/create_edit_article_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/models/news_model.dart';

class CreateEditArticleScreen extends StatefulWidget {
  final NewsArticle? article; // Jika null, berarti mode "Create"

  const CreateEditArticleScreen({super.key, this.article});

  @override
  State<CreateEditArticleScreen> createState() =>
      _CreateEditArticleScreenState();
}

class _CreateEditArticleScreenState extends State<CreateEditArticleScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  late TextEditingController _readTimeController;
  late TextEditingController _imageUrlController;
  late TextEditingController _tagsController;
  late TextEditingController _contentController;

  bool get _isEditing => widget.article != null;

  @override
  void initState() {
    super.initState();
    final article = widget.article;

    _titleController = TextEditingController(text: article?.title ?? '');
    _categoryController = TextEditingController(text: article?.category ?? '');
    _readTimeController = TextEditingController(text: article?.readTime ?? '');
    _imageUrlController = TextEditingController(text: article?.imageUrl ?? '');
    _tagsController =
        TextEditingController(text: article?.tags.join(', ') ?? '');
    _contentController = TextEditingController(text: article?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _readTimeController.dispose();
    _imageUrlController.dispose();
    _tagsController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final provider = Provider.of<NewsProvider>(context, listen: false);

      final articleData = {
        "title": _titleController.text,
        "category": _categoryController.text,
        "readTime": _readTimeController.text,
        "imageUrl": _imageUrlController.text,
        "tags": _tagsController.text.split(',').map((e) => e.trim()).toList(),
        "content": _contentController.text,
      };

      bool success;
      if (_isEditing) {
        success = await provider.updateArticle(widget.article!.id, articleData);
      } else {
        success = await provider.createArticle(articleData);
      }

      if (mounted && success) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Artikel berhasil disimpan!')),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Gagal menyimpan artikel.'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Artikel' : 'Buat Artikel Baru'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _submitForm,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (value) =>
                    value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori'),
                validator: (value) =>
                    value!.isEmpty ? 'Kategori tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _readTimeController,
                decoration: const InputDecoration(
                    labelText: 'Waktu Baca (e.g. 5 menit)'),
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL Gambar'),
                keyboardType: TextInputType.url,
                validator: (value) =>
                    value!.isEmpty ? 'URL Gambar tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                    labelText: 'Tags (pisahkan dengan koma)'),
              ),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Konten Artikel'),
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                validator: (value) =>
                    value!.isEmpty ? 'Konten tidak boleh kosong' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                child: const Text('Simpan Artikel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
