// lib/src/views/homepage.dart

import 'package:flutter/material.dart';

class MainWrapperScreen extends StatelessWidget {
  const MainWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda Utama')),
      body: const Center(
        child: Text('Halaman Utama (MainWrapperScreen - akan datang)'),
      ),
    );
  }
}
