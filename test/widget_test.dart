import 'package:flutter_test/flutter_test.dart';

import 'package:agriclima_lstm_707012400102/main.dart';

void main() {
  testWidgets('Beranda menampilkan sambutan AgriClima', (tester) async {
    await tester.pumpWidget(const AgriClimaApp());

    expect(find.text('Selamat Datang di AgriClima LSTM'), findsOneWidget);
    expect(find.text('AgriClima - Beranda'), findsOneWidget);
  });
}
