import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';
import 'app_theme.dart';
import 'pages/input_prediksi_page.dart';
import 'pages/kerangka_navigasi.dart';
import 'pages/tentang_page.dart';
import 'state/prediksi_bloc.dart';
import 'state/tema_bloc.dart';

void main() {
  runApp(const AgriClimaApp());
}

class AgriClimaApp extends StatelessWidget {
  const AgriClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrediksiBloc()),
        BlocProvider(create: (_) => TemaBloc()),
      ],
      child: BlocBuilder<TemaBloc, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            title: 'AgriClima LSTM',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            initialRoute: AppRoutes.beranda,
            routes: {
              AppRoutes.beranda: (_) => const KerangkaNavigasi(),
              AppRoutes.tentang: (_) => const HalamanTentang(),
              AppRoutes.inputPrediksi: (_) => const HalamanInputPrediksi(),
            },
          );
        },
      ),
    );
  }
}
