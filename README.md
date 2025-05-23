
Jika ada pembanding strategi, tulis di referensi 
# PPBM2 – Kumpulan Proyek Flutter

Repositori ini berisi kumpulan proyek Flutter yang digunakan dalam praktikum mata kuliah **Pemrograman Perangkat Bergerak 2 (PPBM2)**. Setiap folder di dalam repositori ini merupakan aplikasi mandiri yang dapat dijalankan secara terpisah.

## Daftar Aplikasi


| ------------ | -------------------------------------- |
| `flutter_m5` | Aplikasi pertama: \[Register, login, product list] |
| `flutter_m2` | Aplikasi kedua: \[Deskripsi singkat]   |
| `flutter_m3` | Aplikasi ketiga: \[Deskripsi singkat]  |## Daftar Aplikasi

| Folder       | Deskripsi Singkat                                   |
| ------------ | --------------------------------------------------- |
| `flutter_m5` | Aplikasi pertama: Register, login, product list     |
| `flutter_m2` | Aplikasi kedua: [Deskripsi singkat]                 |
| `flutter_m3` | Aplikasi ketiga: [Deskripsi singkat]                |


<!-- W
> **Catatan:** Silakan lengkapi deskripsi singkat untuk setiap aplikasi sesuai dengan fungsionalitasnya.
-->
## Prasyarat

Sebelum menjalankan aplikasi, pastikan Anda telah menginstal:

* [Flutter SDK](https://flutter.dev/docs/get-started/install)
* [Android Studio](https://developer.android.com/studio) atau [Visual Studio Code](https://code.visualstudio.com/) dengan plugin Flutter dan Dart
* Emulator Android atau perangkat fisik untuk pengujian

## Cara Menjalankan Aplikasi

1. **Clone repositori ini:**

   ```bash
   git clone https://github.com/IlhamGhaza/PPBM2.git
   cd PPBM2
   ```

2. **Pilih folder aplikasi yang ingin dijalankan:**

   ```bash
   cd flutter_m1  # Ganti dengan nama folder aplikasi yang diinginkan
   ```

3. **Jalankan perintah berikut untuk menginstal dependensi:**

   ```bash
   flutter pub get
   ```

4. **Jalankan aplikasi:**

   ```bash
   flutter run
   ```

> **Tips:** Pastikan web/emulator/perangkat fisik Anda terhubung sebelum menjalankan aplikasi.

## Struktur Proyek

Setiap folder aplikasi memiliki struktur standar proyek Flutter:

```
flutter_mX/
├── android/
├── ios/
├── lib/
│   └── main.dart
├── test/
├── pubspec.yaml
└── README.md
```

## Kontribusi

Kontribusi sangat terbuka! Jika Anda ingin menambahkan fitur atau memperbaiki bug, silakan lakukan fork repositori ini dan ajukan pull request.

## Lisensi

Repositori ini dilisensikan di bawah [MIT License](LICENSE)
