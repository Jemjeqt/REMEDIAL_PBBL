import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/hasil_prediksi.dart';
import '../state/prediksi_bloc.dart';
import '../widgets/status_gaya.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PrediksiBloc>().state;
    final tema = Theme.of(context);
    final skema = tema.colorScheme;
    final gelap = tema.brightness;

    final jumlah = {
      StatusMikroklimat.kering: state.jumlahKering,
      StatusMikroklimat.optimal: state.jumlahOptimal,
      StatusMikroklimat.terlaluLembap: state.jumlahTerlaluLembap,
    };
    final tertinggi = jumlah.values.fold(0, (a, b) => a > b ? a : b);
    final maksY = (tertinggi + 1).toDouble();
    final garis = FlLine(
      color: skema.outlineVariant,
      strokeWidth: 0.8,
      dashArray: const [4, 4],
    );

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Text(
          'Jumlah Prediksi per Status Mikroklimat',
          style: tema.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(8, 20, 16, 8),
          decoration: BoxDecoration(
            color: skema.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: skema.outlineVariant),
          ),
          child: state.total == 0
              ? SizedBox(
                  height: 240,
                  child: Center(
                    child: Text(
                      'Belum ada data',
                      style: tema.textTheme.bodySmall?.copyWith(
                        color: skema.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 280,
                  child: BarChart(
                    BarChartData(
                      maxY: maksY,
                      alignment: BarChartAlignment.spaceAround,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 1,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (_) => garis,
                        getDrawingVerticalLine: (_) => garis,
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          left: BorderSide(color: skema.outlineVariant),
                          bottom: BorderSide(color: skema.outlineVariant),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            reservedSize: 26,
                            getTitlesWidget: (nilai, _) => Text(
                              nilai.toInt().toString(),
                              style: tema.textTheme.labelSmall?.copyWith(
                                color: skema.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 42,
                            getTitlesWidget: (nilai, _) {
                              final statuses = StatusMikroklimat.values;
                              final indeks = nilai.toInt();
                              if (indeks < 0 || indeks >= statuses.length) {
                                return const SizedBox.shrink();
                              }
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  statuses[indeks].label,
                                  textAlign: TextAlign.center,
                                  style: tema.textTheme.labelSmall?.copyWith(
                                    color: skema.onSurfaceVariant,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (grup, _, batang, _) {
                            final status = StatusMikroklimat.values[grup.x];
                            return BarTooltipItem(
                              '${status.label}\n'
                              '${batang.toY.toInt()} prediksi',
                              TextStyle(
                                color: skema.onInverseSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),
                      ),
                      barGroups: List.generate(
                        StatusMikroklimat.values.length,
                        (indeks) {
                          final status = StatusMikroklimat.values[indeks];
                          return BarChartGroupData(
                            x: indeks,
                            barRods: [
                              BarChartRodData(
                                toY: (jumlah[status] ?? 0).toDouble(),
                                width: 26,
                                color: status.warna(gelap),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(3),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
