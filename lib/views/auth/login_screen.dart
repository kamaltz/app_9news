// lib/src/views/auth/login_screen.dart (Lokasi baru)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // Pastikan package ini ada di pubspec.yaml
import 'package:app_9news/src/provider/auth_provider.dart'; // Diperbaiki jalur impor
import 'package:app_9news/src/configs/app_routes.dart'; // Diperbaiki jalur impor

// Asumsi Anda memiliki file-file ini di lib/flutter_flow/
// Jika mereka bukan package terpisah, pastikan jalur ini benar relatif terhadap root lib/
import 'package:app_9news/flutter_flow/flutter_flow_theme.dart'; // Diperbaiki jalur impor
import 'package:app_9news/flutter_flow/flutter_flow_widgets.dart'; // Diperbaiki jalur impor
import 'package:app_9news/flutter_flow/flutter_flow_util.dart'; // Diperbaiki jalur impor

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = context.read<AuthProvider>();
      bool success = await authProvider.login(
        _emailController.text,
        _passwordController.text,
      );

      // Pastikan widget masih mounted sebelum menggunakan BuildContext setelah async gap
      if (!mounted) return;

      if (success) {
        // Navigasi ke halaman utama setelah login berhasil
        context.pushNamed(
          AppRoutes.home,
        ); // Menggunakan context.pushNamed dari flutter_flow_util.dart
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Login gagal. Periksa email dan kata sandi Anda.',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(
        context,
      ).primaryBackground, // Diperbaiki penggunaan tema
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(
          context,
        ).primary, // Diperbaiki penggunaan tema
        title: Text(
          'Login',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            // Diperbaiki penggunaan tema
            fontFamily: GoogleFonts.inter().fontFamily,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    40.0,
                    0.0,
                    0.0,
                  ),
                  child: Text(
                    'Selamat Datang Kembali!',
                    style: FlutterFlowTheme.of(context).headlineLarge.override(
                      // Diperbaiki penggunaan tema
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    8.0,
                    0.0,
                    24.0,
                  ),
                  child: Text(
                    'Silakan masuk untuk melanjutkan.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                      // Diperbaiki penggunaan tema
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Masukkan email Anda...',
                    hintStyle: FlutterFlowTheme.of(
                      context,
                    ).bodyLarge, // Diperbaiki penggunaan tema
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(
                          context,
                        ).alternate, // Diperbaiki penggunaan tema
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(
                          context,
                        ).primary, // Diperbaiki penggunaan tema
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(
                          context,
                        ).error, // Diperbaiki penggunaan tema
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(
                          context,
                        ).error, // Diperbaiki penggunaan tema
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: FlutterFlowTheme.of(
                    context,
                  ).bodyLarge, // Diperbaiki penggunaan tema
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!value.contains('@')) {
                      return 'Masukkan email yang valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    hintText: 'Masukkan kata sandi Anda...',
                    hintStyle: FlutterFlowTheme.of(
                      context,
                    ).bodyLarge, // Diperbaiki penggunaan tema
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(
                          context,
                        ).alternate, // Diperbaiki penggunaan tema
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(
                          context,
                        ).primary, // Diperbaiki penggunaan tema
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(
                          context,
                        ).error, // Diperbaiki penggunaan tema
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(
                          context,
                        ).error, // Diperbaiki penggunaan tema
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: FlutterFlowTheme.of(
                    context,
                  ).bodyLarge, // Diperbaiki penggunaan tema
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata sandi tidak boleh kosong';
                    }
                    if (value.length < 6) {
                      return 'Kata sandi minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                FFButtonWidget(
                  onPressed: authProvider.isLoading ? null : _handleLogin,
                  text: authProvider.isLoading ? 'Memuat...' : 'Login',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                    ),
                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      0.0,
                      0.0,
                      0.0,
                    ),
                    color: FlutterFlowTheme.of(
                      context,
                    ).primary, // Diperbaiki penggunaan tema
                    textStyle: FlutterFlowTheme.of(context).titleMedium
                        .override(
                          // Diperbaiki penggunaan tema
                          fontFamily: GoogleFonts.inter().fontFamily,
                          color: Colors.white,
                        ),
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    16.0,
                    0.0,
                    0.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun?',
                        style: FlutterFlowTheme.of(
                          context,
                        ).bodyMedium, // Diperbaiki penggunaan tema
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRoutes.register,
                          ); // Menggunakan context.pushNamed
                        },
                        child: Text(
                          'Daftar Sekarang',
                          style: FlutterFlowTheme.of(context).bodyMedium
                              .override(
                                // Diperbaiki penggunaan tema
                                fontFamily: GoogleFonts.inter().fontFamily,
                                color: FlutterFlowTheme.of(
                                  context,
                                ).primary, // Diperbaiki penggunaan tema
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
