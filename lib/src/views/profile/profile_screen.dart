import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/auth_provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:app_9news/src/models/news_model.dart';

// Halaman ProfileScreen utama
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman buat artikel (mode create, jadi argumennya null)
          Navigator.pushNamed(context, AppRoutes.createArticle,
              arguments: null);
        },
        tooltip: 'Buat Artikel Baru',
        child: const Icon(Icons.add),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return RefreshIndicator(
            onRefresh: () => newsProvider.fetchUserArticles(),
            child: ListView(
              children: [
                _buildProfileHeader(context, user),
                _buildLogoutButton(context, authProvider),
                const Divider(thickness: 8, height: 32),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Artikel Anda",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildUserArticles(context, newsProvider),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, user) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              user.avatar != null && user.avatar!.isNotEmpty
                  ? user.avatar!
                  : 'https://api.dicebear.com/8.x/initials/png?seed=${user.name}',
            ),
          ),
          const SizedBox(height: 16),
          Text(user.name,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(user.title ?? 'Jabatan tidak tersedia',
              style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          const SizedBox(height: 16),
          _buildUserInfoRow(Icons.email_outlined, user.email),
          const SizedBox(height: 8),
          _buildUserInfoRow(Icons.perm_identity, "ID: ${user.id}"),
        ],
      ),
    );
  }

  Widget _buildUserInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Flexible(
            child: SelectableText(text,
                style: TextStyle(color: Colors.grey[700]))),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0),
      child: OutlinedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text("Keluar"),
        onPressed: () {
          authProvider.logout();
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (route) => false);
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildUserArticles(BuildContext context, NewsProvider provider) {
    if (provider.isUserArticlesLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.userArticles.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Text("Anda belum mempublikasikan artikel."),
        ),
      );
    }
    return ListView.builder(
      itemCount: provider.userArticles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final article = provider.userArticles[index];
        return UserArticleCard(article: article);
      },
    );
  }
}

class UserArticleCard extends StatelessWidget {
  final NewsArticle article;
  const UserArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                article.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(width: 70, height: 70, color: Colors.grey[200]),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                article.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon:
                  Icon(Icons.edit_outlined, color: Colors.blue[700], size: 20),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.createArticle,
                    arguments: article);
              },
              tooltip: 'Edit',
            ),
            IconButton(
              icon:
                  Icon(Icons.delete_outline, color: Colors.red[700], size: 20),
              onPressed: () => _showDeleteConfirmation(context, article.id),
              tooltip: 'Hapus',
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String articleId) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Text('Apakah Anda yakin ingin menghapus artikel ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            TextButton(
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Provider.of<NewsProvider>(ctx, listen: false)
                    .deleteArticle(articleId);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Artikel telah dihapus')));
              },
            ),
          ],
        );
      },
    );
  }
}
