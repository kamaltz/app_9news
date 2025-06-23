// lib/src/views/create_edit_article_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/models/news_model.dart';

class CreateEditArticleScreen extends StatefulWidget {
  final NewsArticle? article;

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

  final Color primaryColor = const Color.fromARGB(255, 78, 70, 234);
  bool get _isEditing => widget.article != null;

  @override
  void initState() {
    super.initState();
    final article = widget.article;
    _titleController = TextEditingController(text: article?.title ?? '');
    _categoryController = TextEditingController(text: article?.category ?? '');
    _readTimeController = TextEditingController(text: article?.readTime ?? '');
    _imageUrlController = TextEditingController(text: article?.imageUrl ?? '');
    _tagsController = TextEditingController(text: article?.tags.join(', ') ?? '');
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
    // Fungsi submit tidak berubah, hanya fokus pada UI
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
          SnackBar(
            content: Text(_isEditing ? 'Artikel berhasil diperbarui!' : 'Artikel berhasil dibuat!'),
            backgroundColor: Colors.green[700],
          ),
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
  
  // Helper widget untuk membuat input field yang konsisten
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
            prefixIcon: Icon(icon, color: primaryColor.withOpacity(0.7)),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Artikel' : 'Buat Artikel Baru',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check_circle_outline, color: primaryColor, size: 28),
            onPressed: _submitForm,
            tooltip: 'Simpan',
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _titleController,
                label: 'Judul Artikel',
                icon: Icons.title_rounded,
                hint: 'Masukkan judul yang menarik',
                validator: (value) =>
                    value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _categoryController,
                      label: 'Kategori',
                      icon: Icons.category_outlined,
                      hint: 'e.g. Teknologi',
                      validator: (value) =>
                          value!.isEmpty ? 'Kategori tidak boleh kosong' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: _readTimeController,
                      label: 'Waktu Baca',
                      icon: Icons.timer_outlined,
                      hint: 'e.g. 5 menit',
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildTextField(
                controller: _imageUrlController,
                label: 'URL Gambar Cover',
                icon: Icons.image_outlined,
                hint: 'https://...',
                keyboardType: TextInputType.url,
                validator: (value) =>
                    value!.isEmpty ? 'URL Gambar tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),

              _buildTextField(
                controller: _tagsController,
                label: 'Tags',
                icon: Icons.tag,
                hint: 'Pisahkan dengan koma: flutter, berita, dll',
              ),
              const SizedBox(height: 20),

              _buildTextField(
                controller: _contentController,
                label: 'Konten Artikel',
                icon: Icons.article_outlined,
                hint: 'Tuliskan isi artikel Anda di sini...',
                maxLines: 12,
                keyboardType: TextInputType.multiline,
                validator: (value) =>
                    value!.isEmpty ? 'Konten tidak boleh kosong' : null,
              ),
              const SizedBox(height: 32),
              
              ElevatedButton.icon(
                icon: Icon(_isEditing ? Icons.save_as_outlined : Icons.add_circle_outline),
                label: Text(
                  _isEditing ? 'Simpan Perubahan' : 'Publikasikan Artikel',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: primaryColor.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}