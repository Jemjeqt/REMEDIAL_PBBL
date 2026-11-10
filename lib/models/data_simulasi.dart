import 'dart:math';

import 'hasil_prediksi.dart';

const List<String> daftarPetak = ['Petak 1', 'Petak 2'];
const List<String> daftarTanaman = ['Padi', 'Jagung', 'Cabai'];
const List<String> daftarPetugas = [
  'Sri Mulya',
  'Rahmat Hidayat',
  'Neng Yuliani',
];

List<HasilPrediksi> buatDataSimulasi() {
  final acak = Random();
  final sekarang = DateTime.now();

  return List.generate(10, (urutan) {
    return HasilPrediksi(
      petak: daftarPetak[acak.nextInt(daftarPetak.length)],
      tanaman: daftarTanaman[acak.nextInt(daftarTanaman.length)],
      suhuUdara: (18 + acak.nextInt(18)).toDouble(),
      kelembapanUdara: (40 + acak.nextInt(61)).toDouble(),
      kelembapanTanah: (20 + acak.nextInt(71)).toDouble(),
      namaPetugas: daftarPetugas[acak.nextInt(daftarPetugas.length)],
      waktu: sekarang.subtract(
        Duration(hours: urutan * 3, minutes: acak.nextInt(60)),
      ),
    );
  });
}
