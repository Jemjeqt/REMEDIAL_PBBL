import 'package:flutter/material.dart';

import '../app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final skema = tema.colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Text(
          'Selamat Datang di AgriClima LSTM',
          style: tema.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Aplikasi untuk mencatat hasil prediksi mikroklimat tanaman di lahan '
          'Kelompok Tani Sri Mulya, agar kebutuhan penyiraman tiap petak mudah '
          'dipantau.',
          style: tema.textTheme.bodySmall?.copyWith(
            color: skema.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: skema.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.memory_outlined, size: 18, color: skema.onSurfaceVariant),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Model: LSTM (Deep Learning)',
                      style: tema.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Prediksi 24 jam ke depan',
                      style: tema.textTheme.bodySmall?.copyWith(
                        color: skema.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '3 parameter: suhu udara, kelembapan udara, '
                      'kelembapan tanah',
                      style: tema.textTheme.bodySmall?.copyWith(
                        color: skema.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.tentang),
          style: FilledButton.styleFrom(
            backgroundColor: skema.surfaceContainerHighest.withValues(alpha: 0.6),
            foregroundColor: skema.onSurface,
            elevation: 0,
            minimumSize: const Size.fromHeight(38),
            shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: const Text('Tentang Aplikasi'),
        ),
      ],
    );
  }
}
