import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/provider/auth_provider.dart';
import 'package:app_9news/src/configs/app_routes.dart';

// Hapus impor FlutterFlow
// import 'package:app_9news/flutter_flow/flutter_flow_theme.dart';
// import 'package:app_9news/flutter_flow/flutter_flow_util.dart';
// import 'package:app_9news/flutter_flow/flutter_flow_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static String routeName = AppRoutes.register;
  static String routePath = '/register';

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

      // Gunakan context.read untuk mengakses provider di luar metode build
      final authProvider = context.read<AuthProvider>();
      final Map<String, dynamic> userData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'title': '', // Sesuaikan jika ada input untuk ini
        'avatar': '', // Sesuaikan jika ada input untuk ini
      };

      bool success = await authProvider.register(userData);

      if (!mounted) return; // Pemeriksaan mounted setelah await

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pendaftaran berhasil! Silakan login.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushNamed(context, AppRoutes.login);
      } else {
        final errorMessage =
            authProvider.errorMessage ?? 'Pendaftaran gagal. Coba lagi.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan context.watch untuk mendengarkan perubahan pada provider di dalam metode build
    final authProvider = context.watch<AuthProvider>();
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text(
          'Daftar Akun Baru',
          style: textTheme.headlineSmall?.copyWith(
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
                    style: textTheme.headlineLarge?.copyWith(
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
                    style: textTheme.bodyMedium?.copyWith(
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    hintText: 'Masukkan nama lengkap Anda...',
                    hintStyle: textTheme.bodyLarge,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.outline,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: textTheme.bodyLarge,
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
                    hintStyle: textTheme.bodyLarge,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.outline,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: textTheme.bodyLarge,
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
                    hintStyle: textTheme.bodyLarge,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.outline,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: textTheme.bodyLarge,
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
                    hintStyle: textTheme.bodyLarge,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.outline,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: colorScheme.error,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  style: textTheme.bodyLarge,
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
                ElevatedButton(
                  onPressed: authProvider.isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50.0),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    authProvider.isLoading ? 'Memuat...' : 'Daftar',
                    style: textTheme.titleMedium?.copyWith(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      color: Colors.white,
                    ),
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
                      Text('Sudah punya akun?', style: textTheme.bodyMedium),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                        child: Text(
                          'Login Sekarang',
                          style: textTheme.bodyMedium?.copyWith(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            color: colorScheme
                                .primary, // Baris ini sudah benar sekarang
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
