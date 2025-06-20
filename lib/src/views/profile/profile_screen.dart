// lib/src/views/profile/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// --- PERBAIKAN DI SINI ---
// Impor setiap provider dari file aslinya
import 'package:app_9news/src/provider/auth_provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';
// ---
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:app_9news/src/views/homepage.dart'; // Impor untuk menggunakan LatestNewsCard

// ... sisa kode ProfileScreen tetap sama ...

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil data dari provider
    final authProvider = Provider.of<AuthProvider>(context);
    final newsProvider = Provider.of<NewsProvider>(context);
    final user = authProvider.user; // Mendapatkan data user yang sedang login

    // Jika user tidak ada (belum login atau data belum dimuat), tampilkan loading
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          // Bagian Header Profil
          _buildProfileHeader(context, user),

          // Tombol Logout
          _buildLogoutButton(context, authProvider),

          const Divider(thickness: 8, height: 32),

          // Bagian Artikel Saya
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Artikel Anda",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildUserArticles(context, newsProvider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk header profil
  Widget _buildProfileHeader(BuildContext context, user) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              // Gunakan URL avatar dari data pengguna, atau gambar default jika kosong
              user.avatar != null && user.avatar!.isNotEmpty
                  ? user.avatar!
                  : 'https://api.dicebear.com/8.x/initials/png?seed=${user.name}',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            user.title ?? 'Jabatan tidak tersedia', // Tampilkan jabatan
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          _buildUserInfoRow(Icons.email_outlined, user.email),
          const SizedBox(height: 8),
          _buildUserInfoRow(Icons.perm_identity, "ID: ${user.id}"),
        ],
      ),
    );
  }

  // Widget untuk baris info (email & ID)
  Widget _buildUserInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Widget untuk tombol logout
  Widget _buildLogoutButton(BuildContext context, AuthProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: OutlinedButton.icon(
        icon: const Icon(Icons.logout),
        label: const Text("Keluar"),
        onPressed: () {
          authProvider.logout();
          // Navigasi ke halaman login dan hapus semua rute sebelumnya
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan daftar artikel pengguna
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

    // Menggunakan kembali widget card dari homepage
    return ListView.builder(
      itemCount: provider.userArticles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final article = provider.userArticles[index];
        return LatestNewsCard(article: article);
      },
    );
  }
}
