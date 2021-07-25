import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeDataExtensions on ThemeData {
  ThemeData withQuizTheme() {
    return copyWith(
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
      ),
      textTheme: GoogleFonts.nunitoTextTheme(
        textTheme.copyWith(
          bodyText2: const TextStyle(fontSize: 18),
          bodyText1: const TextStyle(fontSize: 16),
          button: const TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          headline5: const TextStyle(fontWeight: FontWeight.bold),
          subtitle1: const TextStyle(color: Colors.grey),
        ),
      ),
      primaryTextTheme: GoogleFonts.nunitoTextTheme(primaryTextTheme),
      accentTextTheme: GoogleFonts.nunitoTextTheme(accentTextTheme),
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
