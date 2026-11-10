import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/prediksi_bloc.dart';
import '../state/prediksi_event.dart';
import '../state/tema_bloc.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final skema = tema.colorScheme;
    final state = context.watch<PrediksiBloc>().state;
    final temaBloc = context.watch<TemaBloc>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text(
          'Pengaturan',
          style: tema.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        _kotak(
          tema,
          SwitchListTile(
            value: temaBloc.state == ThemeMode.dark,
            onChanged: (aktif) =>
                context.read<TemaBloc>().add(TemaDiubah(aktif)),
            title: const Text('Mode Gelap'),
            subtitle: const Text('Tema untuk pemakaian malam hari'),
            secondary: Icon(
              temaBloc.state == ThemeMode.dark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Data Prediksi',
          style: tema.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: skema.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        _kotak(
          tema,
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.auto_awesome_outlined, size: 20),
                title: const Text('Muat Data Simulasi'),
                subtitle: const Text('Isi 10 data acak'),
                onTap: () {
                  context.read<PrediksiBloc>().add(const DataSimulasiDimuat());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('10 data simulasi dimuat')),
                  );
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(
                  Icons.delete_sweep_outlined,
                  size: 20,
                  color: skema.error,
                ),
                title: Text(
                  'Hapus Semua Data',
                  style: TextStyle(color: skema.error),
                ),
                subtitle: Text('${state.daftar.length} data tersimpan'),
                onTap: () => _hapusSemua(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kotak(ThemeData tema, Widget isi) {
    return Material(
      color: tema.colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: tema.colorScheme.outlineVariant),
      ),
      child: isi,
    );
  }

  Future<void> _hapusSemua(BuildContext context) async {
    final hapus = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus semua data?'),
        content: const Text(
          'Seluruh riwayat prediksi akan dihapus dan tidak bisa dikembalikan.',
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
    context.read<PrediksiBloc>().add(const SemuaPrediksiDihapus());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semua data dihapus')),
    );
  }
}
