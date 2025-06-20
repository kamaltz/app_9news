import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Hapus import yang tidak digunakan ini (AuthController atau AuthService)
// import 'package:app_9news/src/controller/auth_service.dart'; // Hapus baris ini
import 'package:app_9news/src/provider/auth_provider.dart'; // Pastikan ini diimpor
import 'package:app_9news/src/configs/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _unfocusNode = FocusNode();
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  late bool passwordVisibility;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  // Metode untuk menangani proses login
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // Gunakan context.read untuk mengakses provider di luar metode build
      final authProvider = context.read<AuthProvider>();

      await authProvider.login(
        _emailController!.text,
        _passwordController!.text,
      );

      // PENTING: Lakukan pemeriksaan 'mounted' setelah await
      if (!mounted) return;

      if (authProvider.isAuthenticated) {
        // PENTING: Lakukan pemeriksaan 'mounted' sebelum navigasi
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        // PENTING: Lakukan pemeriksaan 'mounted' sebelum menampilkan SnackBar
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authProvider.errorMessage ?? 'Login gagal')),
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Image.network(
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/news-app-mq22f9/assets/zkr1nait25m0/Logo.png',
                        width: 120,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            4,
                            0,
                            0,
                          ),
                          child: Text(
                            'Isi detail Anda di bawah ini.',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            16,
                            0,
                            0,
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Alamat Email',
                              hintText: 'Masukkan email Anda...',
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
                              filled: true,
                              fillColor: colorScheme.surfaceContainerHighest,
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                    16,
                                    24,
                                    0,
                                    24,
                                  ),
                            ),
                            style: textTheme.bodyLarge,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            16,
                            0,
                            0,
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !passwordVisibility,
                            decoration: InputDecoration(
                              labelText: 'Kata Sandi',
                              hintText: 'Masukkan kata sandi Anda...',
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
                              filled: true,
                              fillColor: colorScheme.surfaceContainerHighest,
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                    16,
                                    24,
                                    0,
                                    24,
                                  ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () =>
                                      passwordVisibility = !passwordVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: colorScheme.onSurfaceVariant,
                                  size: 22,
                                ),
                              ),
                            ),
                            style: textTheme.bodyLarge,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Kata sandi tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            24,
                            0,
                            0,
                          ),
                          child: ElevatedButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : _handleLogin, // Panggil _handleLogin
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              authProvider.isLoading
                                  ? 'Memuat...'
                                  : 'Login', // Tampilkan teks loading
                              style: textTheme.titleMedium?.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            24,
                            0,
                            0,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, AppRoutes.register);
                            },
                            child: Text(
                              'Belum punya akun? Daftar Sekarang',
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
