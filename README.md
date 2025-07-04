
# PPBM2 – Kumpulan Proyek Flutter

Repositori ini berisi kumpulan proyek Flutter yang digunakan dalam praktikum mata kuliah **Praktikum Pemrograman Berbasis Mobile 2 (PPBM2)**. Setiap folder di dalam repositori ini merupakan aplikasi mandiri yang dapat dijalankan secara terpisah.

<!-- ## Daftar Aplikasi


| Folder       | Deskripsi Singkat                                   |
| ------------ | --------------------------------------------------- |
| `flutter_m5` | Aplikasi pertama: Register, login, product list     |
| `flutter_m2` | Aplikasi kedua: [Deskripsi singkat]                 |
| `flutter_m3` | Aplikasi ketiga: [Deskripsi singkat]                | -->


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

## Mengakses Versi Kode Sebelumnya

Untuk melihat atau kembali ke versi kode sebelumnya di branch main/master, Anda dapat menggunakan perintah `git checkout` dengan hash commit yang diinginkan:

1. **Lihat riwayat commit** untuk menemukan hash commit yang diinginkan:
   ```bash
   git log --oneline
   ```
   Contoh output:
   ```
   a1b2c3d (HEAD -> main, origin/main) Update fitur X
   d4e5f6a Perbaiki bug pada halaman login
   7890abc Tambah fitur baru
   ```

2. **Checkout ke commit tertentu** menggunakan hash-nya:
   ```bash
   git checkout d4e5f6a
   ```
   
3. **Kembali ke versi terbaru** (setelah selesai melihat versi lama):
   ```bash
   git checkout main  # atau git checkout master
   ```

> **Catatan:** 
> - Perubahan yang belum di-commit akan tetap ada saat melakukan checkout. Pastikan untuk commit atau stash perubahan Anda terlebih dahulu.
> - Semua commit ada di branch main/master, jadi Anda bisa langsung checkout ke commit tertentu tanpa perlu pindah branch.
> - Untuk melihat perubahan yang ada di commit tertentu, gunakan `git show d4e5f6a`

## Berkontribusi

1. **Buat branch baru** untuk fitur/perbaikan:
   ```bash
   git checkout -b nama-branch-anda
   ```
   
2. **Commit perubahan** Anda:
   ```bash
   git add .
   git commit -m "Deskripsi perubahan"
   ```
   
3. **Push ke remote repository**:
   ```bash
   git push origin nama-branch-anda
   ```

4. Buat **Pull Request** di GitHub untuk menggabungkan perubahan Anda.

## Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE).

---

Dibuat dengan ❤️ untuk keperluan pembelajaran PPBM2

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
