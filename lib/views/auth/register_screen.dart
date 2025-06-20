import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart'; // Pastikan package ini ada di pubspec.yaml
import 'package:app_9news/src/provider/auth_provider.dart'; // Diperbaiki jalur impor
import 'package:app_9news/src/configs/app_routes.dart'; // Diperbaiki jalur impor

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kata sandi dan konfirmasi kata sandi tidak cocok.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final authProvider = context.read<AuthProvider>();
      bool success = await authProvider.register({
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'title': '', // Asumsi title opsional atau default kosong
        'avatar': '', // Asumsi avatar opsional atau default kosong
      });

      // Pastikan widget masih mounted sebelum menggunakan BuildContext setelah async gap
      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pendaftaran berhasil! Silakan login.'),
            backgroundColor: Colors.green,
          ),
        );
        context.pushNamed(AppRoutes.login); // Menggunakan context.pushNamed
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            // Menggunakan const untuk SnackBar agar lebih efisien
            content: Text('Pendaftaran gagal. Coba lagi.'),
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
          'Daftar Akun Baru',
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
                    'Buat Akun Anda',
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
                    'Isi detail di bawah untuk mendaftar.',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                      // Diperbaiki penggunaan tema
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    hintText: 'Masukkan nama lengkap Anda...',
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
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
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
                    hintText: 'Buat kata sandi...',
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
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Kata Sandi',
                    hintText: 'Ketik ulang kata sandi...',
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
                      return 'Konfirmasi kata sandi tidak boleh kosong';
                    }
                    if (value != _passwordController.text) {
                      return 'Kata sandi tidak cocok';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),
                FFButtonWidget(
                  onPressed: authProvider.isLoading ? null : _handleRegister,
                  text: authProvider.isLoading ? 'Memuat...' : 'Daftar',
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
                        'Sudah punya akun?',
                        style: FlutterFlowTheme.of(
                          context,
                        ).bodyMedium, // Diperbaiki penggunaan tema
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRoutes.login,
                          ); // Menggunakan context.pushNamed
                        },
                        child: Text(
                          'Login Sekarang',
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
