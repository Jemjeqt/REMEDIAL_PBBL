import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class TemaEvent {
  const TemaEvent();
}

class TemaDiubah extends TemaEvent {
  const TemaDiubah(this.aktif);

  final bool aktif;
}

class TemaBloc extends Bloc<TemaEvent, ThemeMode> {
  TemaBloc() : super(ThemeMode.light) {
    on<TemaDiubah>((event, emit) {
      emit(event.aktif ? ThemeMode.dark : ThemeMode.light);
    });
  }
}
