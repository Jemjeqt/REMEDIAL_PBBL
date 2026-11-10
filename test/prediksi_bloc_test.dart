import 'package:flutter_test/flutter_test.dart';

import 'package:agriclima_lstm_707012400102/models/hasil_prediksi.dart';
import 'package:agriclima_lstm_707012400102/state/prediksi_bloc.dart';
import 'package:agriclima_lstm_707012400102/state/prediksi_event.dart';
import 'package:agriclima_lstm_707012400102/state/prediksi_state.dart';
import 'package:agriclima_lstm_707012400102/models/data_simulasi.dart';

HasilPrediksi _hasil({
  String petak = 'Petak 1',
  String tanaman = 'Padi',
  double tanah = 50,
}) {
  return HasilPrediksi(
    petak: petak,
    tanaman: tanaman,
    suhuUdara: 28,
    kelembapanUdara: 70,
    kelembapanTanah: tanah,
    namaPetugas: 'Budi',
    waktu: DateTime(2026, 10, 22, 15, 7),
  );
}

void main() {
  group('StatusMikroklimat', () {
    test('menentukan status berdasarkan kelembapan tanah', () {
      expect(
        StatusMikroklimat.dariKelembapanTanah(39.9),
        StatusMikroklimat.kering,
      );
      expect(
        StatusMikroklimat.dariKelembapanTanah(40),
        StatusMikroklimat.optimal,
      );
      expect(
        StatusMikroklimat.dariKelembapanTanah(70),
        StatusMikroklimat.optimal,
      );
      expect(
        StatusMikroklimat.dariKelembapanTanah(70.1),
        StatusMikroklimat.terlaluLembap,
      );
    });
  });

  group('PrediksiBloc', () {
    test('menambah, memfilter, dan menghapus data', () async {
      final bloc = PrediksiBloc();
      final petak1 = _hasil(petak: 'Petak 1', tanah: 35);
      final petak2 = _hasil(petak: 'Petak 2', tanah: 80);

      bloc.add(PrediksiDitambahkan(petak1));
      bloc.add(PrediksiDitambahkan(petak2));
      var state = await bloc.stream.firstWhere((s) => s.daftar.length == 2);
      expect(state.total, 2);
      expect(state.jumlahPerluTindakan, 2);

      bloc.add(const FilterPetakDiubah(FilterPetak.petak1));
      state = await bloc.stream.firstWhere(
        (s) => s.filter == FilterPetak.petak1,
      );
      expect(state.total, 1);
      expect(state.jumlahKering, 1);
      expect(state.jumlahOptimal, 0);

      bloc.add(PrediksiDihapus(petak1));
      state = await bloc.stream.firstWhere((s) => s.daftar.length == 1);
      expect(state.total, 0);

      bloc.add(const SemuaPrediksiDihapus());
      state = await bloc.stream.firstWhere((s) => s.daftar.isEmpty);
      expect(state.total, 0);
      await bloc.close();
    });

    test('data simulasi berisi 10 data dengan rentang nilai benar', () async {
      final data = buatDataSimulasi();

      expect(data, hasLength(10));
      for (final hasil in data) {
        expect(hasil.suhuUdara, inInclusiveRange(18, 35));
        expect(hasil.kelembapanUdara, inInclusiveRange(40, 100));
        expect(hasil.kelembapanTanah, inInclusiveRange(20, 90));
        expect(
          hasil.status,
          StatusMikroklimat.dariKelembapanTanah(hasil.kelembapanTanah),
        );
        expect(hasil.catatanPerawatan, isNotEmpty);
      }
    });
  });
}
