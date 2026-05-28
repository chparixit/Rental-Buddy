import 'package:flutter/material.dart';
import 'package:rental_buddy/screens/home_screen.dart';

class AppTheme {
  // Colors
  static const Color primary = Color(0xFF1A56A0);
  static const Color background = Color(0xFFF0F4FA);
  static const Color white = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'OpenSans',
      scaffoldBackgroundColor: background,
      primaryColor: primary,

      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        background: background,
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w800, color: primary),
        displayMedium: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w800, color: primary),
        titleLarge: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w700, color: primary),
        titleMedium: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w600, color: primary),
        bodyLarge: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w400),
        labelLarge: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w700),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFFAEB8C8)),
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: white,
        ),
      ),
    );
  }
}