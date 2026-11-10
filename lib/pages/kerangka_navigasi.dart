import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_routes.dart';
import '../state/prediksi_bloc.dart';
import 'beranda_page.dart';
import 'pengaturan_page.dart';
import 'prediksi_page.dart';
import 'statistik_page.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeks = 0;

  static const List<String> _namaTab = [
    'Beranda',
    'Prediksi',
    'Statistik',
    'Pengaturan',
  ];

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final skema = tema.colorScheme;
    final perluTindakan = context.select<PrediksiBloc, int>(
      (bloc) => bloc.state.jumlahPerluTindakanTotal,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('AgriClima - ${_namaTab[_indeks]}'),
      ),
      body: IndexedStack(
        index: _indeks,
        children: const [
          HalamanBeranda(),
          PrediksiPage(),
          StatistikPage(),
          PengaturanPage(),
        ],
      ),
      floatingActionButton: _indeks == 1
          ? FloatingActionButton.extended(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.inputPrediksi),
              backgroundColor: skema.surfaceContainerHighest,
              foregroundColor: skema.onSurface,
              elevation: 0,
              shape: StadiumBorder(
                side: BorderSide(color: skema.outlineVariant),
              ),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Prediksi Baru'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: (indeks) => setState(() => _indeks = indeks),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: perluTindakan > 0,
              label: Text('$perluTindakan'),
              child: const Icon(Icons.eco_outlined),
            ),
            selectedIcon: Badge(
              isLabelVisible: perluTindakan > 0,
              label: Text('$perluTindakan'),
              child: const Icon(Icons.eco),
            ),
            label: 'Prediksi',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
