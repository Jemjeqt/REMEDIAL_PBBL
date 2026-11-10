import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color hijauDaun = Color(0xFF2F5D50);
  static const Color tanahKering = Color(0xFFC05621);
  static const Color langitLembap = Color(0xFF3D6E9E);
  static const Color garisTerang = Color(0xFFD9D9D9);
  static const Color garisGelap = Color(0xFF3A3A3A);

  static ThemeData get lightTheme => _susun(Brightness.light);
  static ThemeData get darkTheme => _susun(Brightness.dark);

  static ThemeData _susun(Brightness brightness) {
    final gelap = brightness == Brightness.dark;
    final skema = ColorScheme.fromSeed(
      seedColor: hijauDaun,
      brightness: brightness,
    );
    final latar = gelap ? const Color(0xFF121212) : Colors.white;
    final permukaan = gelap ? const Color(0xFF1B1B1B) : Colors.white;
    final garis = gelap ? garisGelap : garisTerang;

    return ThemeData(
      useMaterial3: true,
      colorScheme: skema.copyWith(surface: permukaan, outlineVariant: garis),
      scaffoldBackgroundColor: latar,
      appBarTheme: AppBarTheme(
        backgroundColor: latar,
        foregroundColor: skema.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: skema.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: permukaan,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: garis),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: false,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: UnderlineInputBorder(borderSide: BorderSide(color: garis)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: garis)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: skema.primary, width: 1.4),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: skema.error),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: skema.error, width: 1.4),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: permukaan,
        elevation: 0,
        height: 64,
        indicatorColor: skema.surfaceContainerHighest,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 22,
            color: states.contains(WidgetState.selected)
                ? skema.onSurface
                : skema.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w400,
            color: states.contains(WidgetState.selected)
                ? skema.onSurface
                : skema.onSurfaceVariant,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.fixed),
      dividerTheme: DividerThemeData(color: garis, space: 1),
    );
  }
}
