import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF1D1D1F);
  static const secondary = Color(0xFF86868B);
  static const accent = Color(0xFF0071E3);
  static const surfaceLight = Color(0xFFF5F5F7);
  static const cardLight = Color(0xFFFFFFFF);

  static const nikahStart = Color(0xFFFF6B9D);
  static const nikahEnd = Color(0xFFC44569);

  static const pegat = Color(0xFFFF3B30);
  static const ratu = Color(0xFFFF9500);
  static const jodoh = Color(0xFF34C759);
  static const topo = Color(0xFF5856D6);
  static const tinari = Color(0xFF007AFF);
  static const padu = Color(0xFFFF2D55);
  static const sujanan = Color(0xFFAF52DE);
  static const pesthi = Color(0xFF30D158);
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.light,
        surface: AppColors.surfaceLight,
      ),
      fontFamily: 'Roboto',
    );

    return base.copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD2D2D7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFD2D2D7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Roboto',
    );

    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF000000),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF1C1C1E),
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: const Color(0xFF2C2C2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static LinearGradient nikahGradient = const LinearGradient(
    colors: [AppColors.nikahStart, AppColors.nikahEnd, AppColors.nikahStart],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

Color colorForItungan(String name) {
  switch (name) {
    case 'PEGAT':
      return AppColors.pegat;
    case 'RATU':
      return AppColors.ratu;
    case 'JODOH':
      return AppColors.jodoh;
    case 'TOPO':
      return AppColors.topo;
    case 'TINARI':
      return AppColors.tinari;
    case 'PADU':
      return AppColors.padu;
    case 'SUJANAN':
      return AppColors.sujanan;
    default:
      return AppColors.pesthi;
  }
}
