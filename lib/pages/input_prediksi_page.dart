import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/data_simulasi.dart';
import '../models/hasil_prediksi.dart';
import '../state/prediksi_bloc.dart';
import '../state/prediksi_event.dart';

class HalamanInputPrediksi extends StatefulWidget {
  const HalamanInputPrediksi({super.key});

  @override
  State<HalamanInputPrediksi> createState() => _HalamanInputPrediksiState();
}

class _HalamanInputPrediksiState extends State<HalamanInputPrediksi> {
  final _formKey = GlobalKey<FormState>();
  final _suhuController = TextEditingController();
  final _kelembapanUdaraController = TextEditingController();
  final _kelembapanTanahController = TextEditingController();
  final _petugasController = TextEditingController();

  String _petak = 'Petak 1';
  String _tanaman = 'Padi';
  bool _dataBenar = false;

  @override
  void dispose() {
    _suhuController.dispose();
    _kelembapanUdaraController.dispose();
    _kelembapanTanahController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  String? _validasiAngka(String? nilai, {bool batasPersen = false}) {
    final teks = nilai?.trim() ?? '';
    final angka = double.tryParse(teks.replaceAll(',', '.'));
    if (angka == null) {
      return batasPersen
          ? 'Masukkan angka 0-100'
          : 'Masukkan angka yang valid';
    }
    if (batasPersen && (angka < 0 || angka > 100)) {
      return 'Nilai harus berada di antara 0-100';
    }
    return null;
  }

  Future<void> _simpan() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final tanah = double.parse(
      _kelembapanTanahController.text.trim().replaceAll(',', '.'),
    );
    final status = StatusMikroklimat.dariKelembapanTanah(tanah);

    final disetujui = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Text(
          'Simpan prediksi $_tanaman di $_petak?\n'
          'Status: ${status.label}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Ya, Simpan'),
          ),
        ],
      ),
    );
    if (disetujui != true || !mounted) return;

    context.read<PrediksiBloc>().add(
          PrediksiDitambahkan(
            HasilPrediksi(
              petak: _petak,
              tanaman: _tanaman,
              suhuUdara: double.parse(
                _suhuController.text.trim().replaceAll(',', '.'),
              ),
              kelembapanUdara: double.parse(
                _kelembapanUdaraController.text.trim().replaceAll(',', '.'),
              ),
              kelembapanTanah: tanah,
              namaPetugas: _petugasController.text.trim(),
              waktu: DateTime.now(),
            ),
          ),
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data tersimpan')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Input Prediksi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
          children: [
            Text('Petak', style: tema.textTheme.bodySmall),
            RadioGroup<String>(
              groupValue: _petak,
              onChanged: (nilai) {
                if (nilai == null) return;
                setState(() => _petak = nilai);
              },
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: 'Petak 1',
                    title: const Text('Petak 1'),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                  RadioListTile<String>(
                    value: 'Petak 2',
                    title: const Text('Petak 2'),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _tanaman,
              decoration: const InputDecoration(labelText: 'Nama Tanaman'),
              items: daftarTanaman
                  .map(
                    (nama) => DropdownMenuItem(value: nama, child: Text(nama)),
                  )
                  .toList(),
              onChanged: (nilai) {
                if (nilai == null) return;
                setState(() => _tanaman = nilai);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _suhuController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,-]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Prediksi Suhu Udara (°C)',
              ),
              validator: _validasiAngka,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kelembapanUdaraController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Prediksi Kelembapan Udara (%)',
              ),
              validator: (nilai) => _validasiAngka(nilai, batasPersen: true),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kelembapanTanahController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Prediksi Kelembapan Tanah (%)',
              ),
              validator: (nilai) => _validasiAngka(nilai, batasPersen: true),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _petugasController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Nama Petugas'),
              validator: (nilai) => (nilai?.trim().isEmpty ?? true)
                  ? 'Nama petugas wajib diisi'
                  : null,
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              value: _dataBenar,
              onChanged: (nilai) => setState(() => _dataBenar = nilai ?? false),
              title: const Text('Data sudah benar'),
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _dataBenar ? _simpan : null,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
