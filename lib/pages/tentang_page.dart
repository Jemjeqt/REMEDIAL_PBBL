import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final skema = tema.colorScheme;
    final teks = tema.textTheme.bodySmall?.copyWith(
      color: skema.onSurfaceVariant,
      height: 1.5,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Text(
            'Tujuan Aplikasi',
            style: tema.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Membantu petugas mencatat hasil prediksi mikroklimat dari model '
            'LSTM, menampilkan riwayat, serta menentukan status mikroklimat '
            'dan rekomendasi perawatan berdasarkan kelembapan tanah.',
            style: teks,
          ),
          const SizedBox(height: 18),
          Text(
            'Lokasi Pemantauan',
            style: tema.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text('Lahan Kelompok Tani Sri Mulya, Kabupaten Garut.', style: teks),
          const SizedBox(height: 4),
          Text('Petak 1 dan Petak 2', style: teks),
          const SizedBox(height: 18),
          Text(
            'Parameter Mikroklimat',
            style: tema.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          _parameter(tema, 'Suhu udara', 'Derajat Celsius'),
          _parameter(tema, 'Kelembapan udara', 'Persen'),
          _parameter(
            tema,
            'Kelembapan tanah',
            'Persen, dasar penentuan status mikroklimat',
          ),
          const SizedBox(height: 18),
          Text(
            'Model LSTM memprediksi kondisi mikroklimat 24 jam ke depan. '
            'Versi prototipe ini menggunakan data prediksi yang dimasukkan '
            'manual, tanpa API maupun koneksi internet.',
            style: teks,
          ),
        ],
      ),
    );
  }

  Widget _parameter(ThemeData tema, String nama, String keterangan) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: tema.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(nama, style: tema.textTheme.bodySmall),
          ),
          Text(
            keterangan,
            style: tema.textTheme.bodySmall?.copyWith(
              color: tema.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
