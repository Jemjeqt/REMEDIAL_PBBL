# AgriClima LSTM

Prototipe aplikasi Flutter untuk mencatat hasil prediksi mikroklimat tanaman Kelompok Tani Sri Mulya. Hasil prediksi LSTM (suhu udara, kelembapan udara, kelembapan tanah) dimasukkan manual, lalu aplikasi menentukan status mikroklimat, rekomendasi, dan catatan perawatan tanaman.

## Fitur

- Empat tab: Beranda, Prediksi, Statistik, Pengaturan, dengan `NavigationBar` dan `IndexedStack`.
- Form input prediksi dengan validasi angka, dialog konfirmasi, dan SnackBar.
- Status mikroklimat dari kelembapan tanah: Kering (< 40%), Optimal (40–70%), Terlalu Lembap (> 70%).
- State management BLoC untuk data prediksi dan mode tema.
- Riwayat prediksi dengan filter petak, kartu statistik, dan Badge Perlu Tindakan.
- Data simulasi 10 data acak dan `BarChart` (`fl_chart`) jumlah prediksi per status.
- Tema terang dan gelap dengan `ColorScheme.fromSeed()`.

## Struktur

```text
lib/
├── main.dart
├── app_routes.dart
├── app_theme.dart
├── models/
├── pages/
├── state/
└── widgets/
```

## Menjalankan

```bash
flutter pub get
flutter run
```

## Dependensi

`flutter_bloc`, `equatable`, `fl_chart`.

## Catatan

Data prediksi disimpan di memori, sehingga riwayat hilang saat aplikasi ditutup. Aplikasi tidak memanggil API atau koneksi internet.
