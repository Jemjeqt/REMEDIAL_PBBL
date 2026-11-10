import 'catatan_perawatan.dart';

enum StatusMikroklimat {
  kering('Kering', 'Segera lakukan penyiraman atau irigasi'),
  optimal('Optimal', 'Pertahankan pola perawatan saat ini'),
  terlaluLembap('Terlalu Lembap', 'Kurangi penyiraman dan periksa drainase');

  const StatusMikroklimat(this.label, this.rekomendasi);

  final String label;
  final String rekomendasi;

  static StatusMikroklimat dariKelembapanTanah(double nilai) {
    if (nilai < 40) return StatusMikroklimat.kering;
    if (nilai <= 70) return StatusMikroklimat.optimal;
    return StatusMikroklimat.terlaluLembap;
  }
}

class HasilPrediksi {
  HasilPrediksi({
    required this.petak,
    required this.tanaman,
    required this.suhuUdara,
    required this.kelembapanUdara,
    required this.kelembapanTanah,
    required this.namaPetugas,
    required this.waktu,
  });

  final String petak;
  final String tanaman;
  final double suhuUdara;
  final double kelembapanUdara;
  final double kelembapanTanah;
  final String namaPetugas;
  final DateTime waktu;

  StatusMikroklimat get status =>
      StatusMikroklimat.dariKelembapanTanah(kelembapanTanah);

  String get rekomendasi => status.rekomendasi;

  String get catatanPerawatan => catatanPerawatanPerTanaman[tanaman] ?? '';
}
