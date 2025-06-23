9News App
Selamat datang di 9News, sebuah aplikasi berita modern yang dibangun menggunakan Flutter. Aplikasi ini berfungsi sebagai gerbang pribadi Anda menuju berita terkini dan kisah yang sedang tren dari seluruh dunia, dirancang untuk memberikan pengalaman membaca berita yang personal dan andal.
Aplikasi ini terhubung dengan REST API untuk mengelola data berita, pengguna, dan artikel, serta menyediakan fitur autentikasi dan manajemen konten bagi pengguna.

Fitur Utama
Autentikasi Pengguna: Sistem lengkap untuk registrasi dan login pengguna
Beranda Dinamis: Menampilkan berita yang sedang tren dalam format carousel dan daftar berita terbaru untuk menjaga pengguna tetap update
Jelajahi & Cari: Halaman "Jelajah" memungkinkan pengguna untuk mencari artikel berdasarkan kata kunci atau memfilter berdasarkan kategori seperti Nasional, Teknologi, Bola, dan lainnya
Bookmark Artikel: Pengguna dapat menyimpan artikel yang mereka sukai dan membacanya kembali di halaman "Tersimpan"
Manajemen Artikel (CRUD): Pengguna yang terautentikasi dapat membuat, melihat, mengedit, dan menghapus artikel berita mereka sendiri melalui halaman profil
Profil Penulis: Lihat detail profil seorang penulis beserta daftar semua artikel yang telah mereka tulis
UI Responsif: Dibangun dengan flutter_screenutil untuk memastikan tampilan yang konsisten di berbagai ukuran layar
Onboarding Pengguna: Serangkaian layar perkenalan untuk menyambut pengguna baru dan menjelaskan fitur-fitur utama aplikasi
Teknologi & Dependensi Utama
Framework: Flutter
Manajemen State: Provider
Networking: http
Penyimpanan Lokal: shared_preferences
UI: google_fonts, flutter_screenutil, carousel_slider
Ikon Aplikasi: flutter_launcher_icons

Memulai
Untuk menjalankan proyek ini di lingkungan lokal Anda, ikuti langkah-langkah berikut.
Prasyarat
Pastikan Anda telah menginstal Flutter SDK (versi 3.0.0 atau lebih tinggi).
Sebuah emulator Android/iOS atau perangkat fisik.
Instalasi & Menjalankan
Clone repositori:
git clone https://github.com/kamaltz/app_9news.git
cd app_9news

Instal dependensi:
Buka terminal di direktori root proyek dan jalankan:
flutter pub get

Jalankan Aplikasi:
Pastikan perangkat atau emulator Anda berjalan, lalu jalankan perintah berikut:
flutter run

Struktur Proyek
Struktur direktori utama lib diatur sebagai berikut untuk menjaga keterbacaan dan skalabilitas kode:
lib/
├── src/
│ ├── configs/ # Konfigurasi, seperti routing (app_routes.dart)
│ ├── controller/ # Logika bisnis dan interaksi dengan API (auth_service.dart, news_service.dart)
│ ├── models/ # Model data untuk parsing JSON (auth_model.dart, news_model.dart)
│ ├── provider/ # State management menggunakan Provider (auth_provider.dart, news_provider.dart)
│ ├── views/ # Layer UI, berisi semua layar aplikasi
│ │ ├── auth/
│ │ ├── author/
│ │ ├── bookmarks/
│ │ ├── explore/
│ │ ├── news/
│ │ ├── onboarding/
│ │ └── profile/
│ └── widgets/ # Widget yang dapat digunakan kembali (reusable)
└── main.dart # Titik masuk utama aplikasi
