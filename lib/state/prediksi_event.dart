import 'package:equatable/equatable.dart';

import '../models/hasil_prediksi.dart';
import 'prediksi_state.dart';

sealed class PrediksiEvent extends Equatable {
  const PrediksiEvent();

  @override
  List<Object?> get props => [];
}

class PrediksiDitambahkan extends PrediksiEvent {
  const PrediksiDitambahkan(this.hasil);

  final HasilPrediksi hasil;

  @override
  List<Object?> get props => [hasil];
}

class PrediksiDihapus extends PrediksiEvent {
  const PrediksiDihapus(this.hasil);

  final HasilPrediksi hasil;

  @override
  List<Object?> get props => [hasil];
}

class SemuaPrediksiDihapus extends PrediksiEvent {
  const SemuaPrediksiDihapus();
}

class DataSimulasiDimuat extends PrediksiEvent {
  const DataSimulasiDimuat();
}

class FilterPetakDiubah extends PrediksiEvent {
  const FilterPetakDiubah(this.filter);

  final FilterPetak filter;

  @override
  List<Object?> get props => [filter];
}
