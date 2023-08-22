import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  TextStyles._();

  static const double _scale = 1.0;

  static TextStyle get headline1 => GoogleFonts.roboto(fontSize: 20 * _scale);
  static TextStyle get headline2 => GoogleFonts.roboto(fontSize: 26 * _scale);
  static TextStyle get headline3 => GoogleFonts.roboto(fontSize: 24 * _scale);
  static TextStyle get headline4 => GoogleFonts.roboto(fontSize: 22 * _scale);
  static TextStyle get headline5 => GoogleFonts.roboto(fontSize: 20 * _scale);
  static TextStyle get headline6 => GoogleFonts.roboto(fontSize: 18 * _scale);
  static TextStyle get subtitle1 => GoogleFonts.roboto(fontSize: 16 * _scale);
  static TextStyle get subtitle2 => GoogleFonts.roboto(fontSize: 14 * _scale);
  static TextStyle get bodyText1 => GoogleFonts.roboto();
  static TextStyle get bodyText2 => GoogleFonts.roboto();
  static TextStyle get caption => GoogleFonts.roboto();
  static TextStyle get button => GoogleFonts.roboto(fontSize: 14 * _scale);
  static TextStyle get overline => GoogleFonts.roboto();
}

extension TextStyleWeightExtension on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get black => copyWith(fontWeight: FontWeight.w900);
}

extension TextStyleHelpers on TextStyle {
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle letterSpace(double value) => copyWith(letterSpacing: value);
  TextStyle height(double value) => copyWith(height: value);
}
