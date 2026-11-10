import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/hasil_prediksi.dart';
import '../state/prediksi_bloc.dart';
import '../state/prediksi_event.dart';
import '../state/prediksi_state.dart';
import '../widgets/prediksi_card.dart';
import '../widgets/stat_card.dart';

class PrediksiPage extends StatelessWidget {
  const PrediksiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PrediksiBloc>().state;
    final tema = Theme.of(context);
    final skema = tema.colorScheme;
    final daftar = state.daftarTerfilter;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Riwayat Prediksi',
            style: tema.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          SegmentedButton<FilterPetak>(
            expandedInsets: EdgeInsets.zero,
            showSelectedIcon: true,
            segments: FilterPetak.values
                .map(
                  (filter) => ButtonSegment(
                    value: filter,
                    label: Text(filter.label),
                  ),
                )
                .toList(),
            selected: {state.filter},
            onSelectionChanged: (pilihan) {
              context
                  .read<PrediksiBloc>()
                  .add(FilterPetakDiubah(pilihan.first));
            },
            style: SegmentedButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              textStyle: const TextStyle(fontSize: 12),
              backgroundColor: skema.surface,
              foregroundColor: skema.onSurfaceVariant,
              selectedBackgroundColor: skema.surface,
              selectedForegroundColor: skema.onSurface,
              side: BorderSide(color: skema.outlineVariant),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: StatCard(label: 'Total', nilai: state.total)),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(label: 'Optimal', nilai: state.jumlahOptimal),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatCard(
                  label: 'Perlu Tindakan',
                  nilai: state.jumlahPerluTindakan,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: daftar.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada data',
                      style: tema.textTheme.bodySmall?.copyWith(
                        color: skema.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(bottom: 96),
                    itemCount: daftar.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, indeks) {
                      final hasil = daftar[indeks];
                      return PrediksiCard(
                        prediksi: hasil,
                        onHapus: () => _konfirmasiHapus(context, hasil),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _konfirmasiHapus(
    BuildContext context,
    HasilPrediksi hasil,
  ) async {
    final hapus = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus data?'),
        content: Text(
          'Data ${hasil.petak} - ${hasil.tanaman} akan dihapus dari riwayat.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (hapus != true || !context.mounted) return;
    context.read<PrediksiBloc>().add(PrediksiDihapus(hasil));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data dihapus')),
    );
  }
}
