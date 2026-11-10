import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';
import 'status_gaya.dart';

class PrediksiCard extends StatelessWidget {
  const PrediksiCard({super.key, required this.prediksi, this.onHapus});

  final HasilPrediksi prediksi;
  final VoidCallback? onHapus;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final skema = tema.colorScheme;
    final warna = prediksi.status.warna(tema.brightness);
    final teksKecil = tema.textTheme.bodySmall?.copyWith(
      color: skema.onSurfaceVariant,
      height: 1.45,
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 6, 12),
      decoration: BoxDecoration(
        color: skema.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: skema.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: skema.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(prediksi.status.ikon, size: 15, color: warna),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${prediksi.petak} - ${prediksi.tanaman}',
                  style: tema.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: onHapus,
                tooltip: 'Hapus data',
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            prediksi.status.label,
            style: tema.textTheme.bodySmall?.copyWith(
              color: warna,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kelembapan tanah: '
                  '${prediksi.kelembapanTanah.toStringAsFixed(1)}%',
                  style: teksKecil,
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: (prediksi.kelembapanTanah / 100).clamp(0, 1),
                    minHeight: 6,
                    color: warna,
                    backgroundColor: skema.surfaceContainerHighest,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Suhu udara: ${prediksi.suhuUdara.toStringAsFixed(1)} °C',
                  style: teksKecil,
                ),
                Text(
                  'Kelembapan udara: '
                  '${prediksi.kelembapanUdara.toStringAsFixed(1)}%',
                  style: teksKecil,
                ),
                const SizedBox(height: 8),
                Text('Rekomendasi: ${prediksi.rekomendasi}', style: teksKecil),
                Text('Catatan: ${prediksi.catatanPerawatan}', style: teksKecil),
                const SizedBox(height: 8),
                Text(
                  '${prediksi.namaPetugas} - ${formatWaktu(prediksi.waktu)}',
                  style: tema.textTheme.bodySmall?.copyWith(
                    color: skema.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String formatWaktu(DateTime waktu) {
  String duaDigit(int nilai) => nilai.toString().padLeft(2, '0');
  return '${duaDigit(waktu.day)}/${duaDigit(waktu.month)}/${waktu.year} '
      '${duaDigit(waktu.hour)}:${duaDigit(waktu.minute)}';
}
