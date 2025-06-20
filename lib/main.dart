// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/configs/app_routes.dart';
// UBAH BARIS INI: Import AuthProvider dari folder provider
import 'package:app_9news/src/provider/auth_provider.dart';
// Hapus atau komentari baris yang mencoba mengimpor AuthController/AuthService dari controller
// import 'package:app_9news/src/controller/AuthService.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // UBAH BARIS INI: Gunakan AuthProvider
        ChangeNotifierProvider(create: (_) => AuthProvider()..initAuth()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '9News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.amber,
          surface: Colors.white,
          onSurface: Colors.black,
          surfaceContainerHighest: Colors.grey[100],
          error: Colors.red,
          onError: Colors.white,
          outline: Colors.grey,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16.0),
          bodyMedium: TextStyle(fontSize: 14.0),
          bodySmall: TextStyle(fontSize: 12.0),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.blue),
        ),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
