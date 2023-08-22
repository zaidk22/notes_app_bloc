import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static TextTheme get light => ThemeData.light().textTheme.copyWith(
        displayLarge: GoogleFonts.roboto(fontSize: 20),
        displayMedium: GoogleFonts.roboto(fontSize: 26),
        displaySmall: GoogleFonts.roboto(fontSize: 24),
        headlineMedium: GoogleFonts.roboto(fontSize: 22),
        headlineSmall: GoogleFonts.roboto(fontSize: 20),
        titleLarge: GoogleFonts.roboto(fontSize: 18),
        titleMedium: GoogleFonts.roboto(fontSize: 16),
        titleSmall: GoogleFonts.roboto(fontSize: 14),
        bodyLarge: GoogleFonts.roboto(),
        bodyMedium: GoogleFonts.roboto(),
        bodySmall: GoogleFonts.roboto(),
        labelLarge: GoogleFonts.roboto(fontSize: 14),
        labelSmall: GoogleFonts.roboto(),
      );
  static TextTheme get dark => ThemeData.dark().textTheme.copyWith(
        displayLarge: GoogleFonts.roboto(fontSize: 20),
        displayMedium: GoogleFonts.roboto(fontSize: 26),
        displaySmall: GoogleFonts.roboto(fontSize: 24),
        headlineMedium: GoogleFonts.roboto(fontSize: 22),
        headlineSmall: GoogleFonts.roboto(fontSize: 20),
        titleLarge: GoogleFonts.roboto(fontSize: 18),
        titleMedium: GoogleFonts.roboto(fontSize: 16),
        titleSmall: GoogleFonts.roboto(fontSize: 14),
        bodyLarge: GoogleFonts.roboto(),
        bodyMedium: GoogleFonts.roboto(),
        bodySmall: GoogleFonts.roboto(),
        labelLarge: GoogleFonts.roboto(fontSize: 14),
        labelSmall: GoogleFonts.roboto(),
      );
}
