// lib/src/views/auth/auth_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/auth_provider.dart';
import 'package:app_9news/src/configs/app_routes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controllers untuk form Login
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  // Controllers untuk form Register
  final _registerNameController = TextEditingController();
  final _registerTitleController =
      TextEditingController(); // Untuk Jabatan/Title
  final _registerAvatarController =
      TextEditingController(); // <-- BARU: Untuk URL Avatar
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();

  bool _loginPasswordVisible = false;
  bool _registerPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerTitleController.dispose();
    _registerAvatarController.dispose(); // <-- BARU: Dispose controller avatar
    super.dispose();
  }

  // --- FUNGSI UNTUK MENANGANI LOGIN ---
  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.login(
      _loginEmailController.text.trim(),
      _loginPasswordController.text.trim(),
    );

    if (!mounted) return;

    if (authProvider.isLoggedIn) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Login gagal.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  // --- FUNGSI UNTUK MENANGANI REGISTER ---
  Future<void> _handleRegister() async {
    FocusScope.of(context).unfocus();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // --- PERBAIKAN DI SINI: Sesuaikan dengan semua field yang dibutuhkan API ---
    final userData = {
      'name': _registerNameController.text.trim(),
      'email': _registerEmailController.text.trim(),
      'password': _registerPasswordController.text.trim(),
      'title': _registerTitleController.text.trim(), // Jabatan dari UI
      'avatar': _registerAvatarController.text.trim(), // URL Avatar dari UI
    };

    bool success = await authProvider.register(userData);

    if (!mounted) return;

    if (success) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Registrasi gagal.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: AbsorbPointer(
        absorbing: authProvider.isLoading,
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0, bottom: 40.0),
                        child: Image.asset(
                          'assets/images/Logo.png',
                          width: 160.0,
                          height: 60.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TabBar(
                              controller: _tabController,
                              labelColor: theme.primaryColor,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: theme.primaryColor,
                              indicatorWeight: 3,
                              labelStyle: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold),
                              tabs: const [
                                Tab(text: 'Masuk'),
                                Tab(text: 'Daftar'),
                              ],
                            ),
                            SizedBox(
                              height:
                                  450, // Sesuaikan tinggi untuk menampung field baru
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  _buildLoginTab(context),
                                  _buildRegisterTab(context),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Tampilkan Indikator Loading di tengah layar
            if (authProvider.isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Form Login
  Widget _buildLoginTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _loginEmailController,
            decoration: _buildInputDecoration('Email', Icons.email_outlined),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _loginPasswordController,
            obscureText: !_loginPasswordVisible,
            decoration: _buildInputDecoration('Kata Sandi', Icons.lock_outline)
                .copyWith(
              suffixIcon: IconButton(
                icon: Icon(
                  _loginPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () => setState(
                    () => _loginPasswordVisible = !_loginPasswordVisible),
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Masuk',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Form Register
  Widget _buildRegisterTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: _registerNameController,
              decoration:
                  _buildInputDecoration('Nama Pengguna', Icons.person_outline),
            ),
            const SizedBox(height: 16),
            // --- PERBAIKAN 1: Mengubah "Nomor" menjadi "Jabatan" ---
            TextFormField(
              controller: _registerTitleController,
              decoration: _buildInputDecoration(
                  'Jabatan (e.g. Developer)', Icons.work_outline),
            ),
            const SizedBox(height: 16),
            // --- PERBAIKAN 2: Menambahkan field "URL Avatar" ---
            TextFormField(
              controller: _registerAvatarController,
              decoration:
                  _buildInputDecoration('URL Gambar Avatar', Icons.link),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _registerEmailController,
              decoration: _buildInputDecoration('Email', Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _registerPasswordController,
              obscureText: !_registerPasswordVisible,
              decoration:
                  _buildInputDecoration('Kata Sandi', Icons.lock_outline)
                      .copyWith(
                suffixIcon: IconButton(
                  icon: Icon(
                    _registerPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() =>
                      _registerPasswordVisible = !_registerPasswordVisible),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _handleRegister,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Daftar',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk dekorasi input
  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme.of(context).primaryColor)));
  }
}
