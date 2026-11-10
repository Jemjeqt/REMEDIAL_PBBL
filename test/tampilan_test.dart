import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agriclima_lstm_707012400102/main.dart';

void main() {
  testWidgets('Tampilan utama tidak overflow di layar kecil', (tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const AgriClimaApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pengaturan').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Muat Data Simulasi'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Prediksi').last);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Perlu Tindakan'), findsOneWidget);

    await tester.tap(find.text('Statistik').last);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Jumlah Prediksi per Status Mikroklimat'), findsOneWidget);
  });
}
