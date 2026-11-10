import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.nilai,
  });

  final String label;
  final int nilai;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final skema = tema.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: skema.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: skema.outlineVariant),
      ),
      child: Column(
        children: [
          Text(
            '$nilai',
            style: tema.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: tema.textTheme.bodySmall?.copyWith(
              color: skema.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
