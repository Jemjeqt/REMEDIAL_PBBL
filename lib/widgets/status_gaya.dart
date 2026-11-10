import 'package:flutter/material.dart';

import '../models/hasil_prediksi.dart';

extension StatusGaya on StatusMikroklimat {
  Color warna(Brightness brightness) {
    final gelap = brightness == Brightness.dark;
    return switch (this) {
      StatusMikroklimat.kering =>
        gelap ? const Color(0xFFE9A25C) : const Color(0xFFC05621),
      StatusMikroklimat.optimal =>
        gelap ? const Color(0xFF7FC9A8) : const Color(0xFF2F5D50),
      StatusMikroklimat.terlaluLembap =>
        gelap ? const Color(0xFF93B9DD) : const Color(0xFF3D6E9E),
    };
  }

  IconData get ikon => switch (this) {
        StatusMikroklimat.kering => Icons.wb_sunny_outlined,
        StatusMikroklimat.optimal => Icons.eco_outlined,
        StatusMikroklimat.terlaluLembap => Icons.water_drop_outlined,
      };
}
