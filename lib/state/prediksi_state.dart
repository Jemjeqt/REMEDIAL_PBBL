import 'package:equatable/equatable.dart';

import '../models/hasil_prediksi.dart';

enum FilterPetak {
  semua('Semua'),
  petak1('Petak 1'),
  petak2('Petak 2');

  const FilterPetak(this.label);

  final String label;
}

class PrediksiState extends Equatable {
  const PrediksiState({
    this.daftar = const [],
    this.filter = FilterPetak.semua,
  });

  final List<HasilPrediksi> daftar;
  final FilterPetak filter;

  List<HasilPrediksi> get daftarTerfilter => switch (filter) {
        FilterPetak.semua => daftar,
        FilterPetak.petak1 =>
          daftar.where((item) => item.petak == 'Petak 1').toList(),
        FilterPetak.petak2 =>
          daftar.where((item) => item.petak == 'Petak 2').toList(),
      };

  int get total => daftarTerfilter.length;
  int get jumlahOptimal => _hitung(StatusMikroklimat.optimal);
  int get jumlahKering => _hitung(StatusMikroklimat.kering);
  int get jumlahTerlaluLembap => _hitung(StatusMikroklimat.terlaluLembap);

  int get jumlahPerluTindakan => daftarTerfilter
      .where((item) => item.status != StatusMikroklimat.optimal)
      .length;

  int get jumlahPerluTindakanTotal => daftar
      .where((item) => item.status != StatusMikroklimat.optimal)
      .length;

  int _hitung(StatusMikroklimat status) =>
      daftarTerfilter.where((item) => item.status == status).length;

  PrediksiState copyWith({
    List<HasilPrediksi>? daftar,
    FilterPetak? filter,
  }) {
    return PrediksiState(
      daftar: daftar ?? this.daftar,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [daftar, filter];
}
