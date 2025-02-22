import 'package:flutter/material.dart';
import 'package:example_app/common/themes/text.dart';
import 'package:example_app/common/themes/colors.dart';

// this should be adjusted to match the dark theme structure
const ColorScheme _lightColors = ColorScheme(
  brightness: Brightness.light,
  primary: primary,
  onPrimary: white,
  primaryContainer: primaryLight,
  onPrimaryContainer: darkerGrey,
  secondary: secondary,
  onSecondary: white,
  secondaryContainer: secondaryLight,
  onSecondaryContainer: darkerGrey,
  tertiary: tertiary,
  onTertiary: white,
  tertiaryContainer: tertiaryLight,
  onTertiaryContainer: darkerGrey,
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: white,
  onErrorContainer: Color(0xFF410002),
  surface: white,
  onSurface: darkGrey,
  outline: grey,
  onInverseSurface: white,
  inverseSurface: darkGrey,
  inversePrimary: primaryDark,
  shadow: Color(0xFF1A1A1A), // off black
  surfaceTint: primary,
  outlineVariant: grey,
  scrim: Color(0xFF1A1A1A), // off black
);

final TextTheme _lightTextTheme = TextTheme(
  // Main title, biggest boi
  displayLarge: appTextTheme.displayLarge?.copyWith(
    color: darkerGrey,
  ),
  // less biggest boi
  displayMedium: appTextTheme.displayMedium?.copyWith(
    color: darkerGrey,
  ),
  // not so big boi
  displaySmall: appTextTheme.displaySmall?.copyWith(
    color: darkerGrey,
  ),
  // profile card and other large-ish titles
  titleLarge: appTextTheme.titleLarge?.copyWith(
    color: darkGrey,
  ),
  // FAQ page and other text titles
  titleMedium: appTextTheme.titleMedium?.copyWith(
    color: darkGrey,
  ),
  // Puzzle title on homepage and other smaller titles
  titleSmall: appTextTheme.titleSmall?.copyWith(
    color: darkGrey,
  ),
  // Profile name on leaderboard
  labelLarge: appTextTheme.labelLarge?.copyWith(
    color: darkGrey,
  ),
  // FAQ/Setting row titles
  labelMedium: appTextTheme.labelMedium?.copyWith(
    color: darkGrey,
  ),
  // tab navigation
  labelSmall: appTextTheme.labelSmall?.copyWith(
    color: grey,
  ),
  bodyLarge: appTextTheme.bodyLarge?.copyWith(
    color: grey,
  ),
  // typical body font
  bodyMedium: appTextTheme.bodyMedium?.copyWith(
    color: grey,
  ),
  // little bois
  bodySmall: appTextTheme.bodySmall?.copyWith(
    color: grey,
  ),
);

final ThemeData lightTheme = ThemeData(
  colorScheme: _lightColors,
  useMaterial3: true,
  fontFamily: defaultFontFamily,
  textTheme: _lightTextTheme,
);
