import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final defaultFontFamily = GoogleFonts.roboto.toString();

final TextTheme appTextTheme = TextTheme(
  // Main title, biggest boi
  displayLarge: GoogleFonts.roboto(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    // height: 34,
  ),
  // less biggest boi
  displayMedium: GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    // height: 30,
  ),
  // not so big boi
  displaySmall: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    // height: 24,
  ),
  // profile card and other large-ish titles
  titleLarge: GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    // height: 20,
  ),
  // FAQ page and other text titles
  titleMedium: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    // height: 14,
  ),
  // Puzzle title on homepage and other smaller titles
  titleSmall: GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    // height: 11,
  ),
  // Profile name on leaderboard
  labelLarge: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    // height: 15,
  ),
  // FAQ/Setting row titles
  labelMedium: GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    // height: 11,
  ),
  // tab navigation
  labelSmall: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    // height: 10,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    // height: 13,
  ),
  // typical body font
  bodyMedium: GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    // height: 10,
  ),
  // little bois
  bodySmall: GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    // height: 6,
  ),
);
