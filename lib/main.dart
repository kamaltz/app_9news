import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:app_9news/src/configs/app_routes.dart';
import 'package:app_9news/src/provider/auth_provider.dart';
import 'package:app_9news/src/provider/news_provider.dart';

void main() {
  runApp(const AppProviders());
}

// Widget ini bertanggung jawab untuk menyediakan semua provider
class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: const MyApp(), // Lanjutkan ke MyApp setelah provider siap
    );
  }
}

// Widget ini bertanggung jawab untuk inisialisasi ScreenUtil dan MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi ScreenUtil di sini, membungkus MaterialApp
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Ukuran desain referensi Anda
      minTextAdapt: true,
      splitScreenMode:
          true, // Pastikan ini diatur jika Anda butuh mode split screen
      // Builder akan dieksekusi setelah ScreenUtil siap
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '9News App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          // Rute awal diarahkan ke splash screen
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
