import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizTheme {
  static ThemeData dark() => ThemeData.dark().applyQuizTheme();
}

extension _ThemeDataExtensions on ThemeData {
  ThemeData applyQuizTheme() {
    return copyWith(
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
      ),
      textTheme: GoogleFonts.nunitoTextTheme(
        textTheme.copyWith(
          bodyMedium: const TextStyle(fontSize: 18),
          bodyLarge: const TextStyle(fontSize: 16),
          labelLarge: const TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: const TextStyle(fontWeight: FontWeight.bold),
          titleMedium: const TextStyle(color: Colors.grey),
        ),
      ),
      primaryTextTheme: GoogleFonts.nunitoTextTheme(primaryTextTheme),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, double.minPositive),
          padding: const EdgeInsets.all(30),
          textStyle: const TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black45,
        contentTextStyle: GoogleFonts.nunito(),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
