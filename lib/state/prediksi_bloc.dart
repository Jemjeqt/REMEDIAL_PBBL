import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/data_simulasi.dart';
import 'prediksi_event.dart';
import 'prediksi_state.dart';

class PrediksiBloc extends Bloc<PrediksiEvent, PrediksiState> {
  PrediksiBloc() : super(const PrediksiState()) {
    on<PrediksiDitambahkan>(_tambah);
    on<PrediksiDihapus>(_hapus);
    on<SemuaPrediksiDihapus>(_hapusSemua);
    on<DataSimulasiDimuat>(_muatSimulasi);
    on<FilterPetakDiubah>(_ubahFilter);
  }

  void _tambah(PrediksiDitambahkan event, Emitter<PrediksiState> emit) {
    emit(state.copyWith(daftar: [event.hasil, ...state.daftar]));
  }

  void _hapus(PrediksiDihapus event, Emitter<PrediksiState> emit) {
    emit(
      state.copyWith(
        daftar: state.daftar.where((item) => item != event.hasil).toList(),
      ),
    );
  }

  void _hapusSemua(SemuaPrediksiDihapus event, Emitter<PrediksiState> emit) {
    emit(state.copyWith(daftar: const []));
  }

  void _muatSimulasi(DataSimulasiDimuat event, Emitter<PrediksiState> emit) {
    emit(state.copyWith(daftar: buatDataSimulasi()));
  }

  void _ubahFilter(FilterPetakDiubah event, Emitter<PrediksiState> emit) {
    emit(state.copyWith(filter: event.filter));
  }
}
