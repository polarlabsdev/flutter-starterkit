import 'package:flutter/material.dart';
import 'package:example_app/common/themes/text.dart';
import 'package:example_app/common/themes/colors.dart';

const ColorScheme _darkColors = ColorScheme(
  brightness: Brightness.dark,
  primary: primary,
  onPrimary: darkGreyGreen,
  primaryContainer: primaryDark,
  onPrimaryContainer: white,
  secondary: secondary,
  onSecondary: darkGreyGreen,
  secondaryContainer: secondaryDark,
  onSecondaryContainer: white,
  tertiary: tertiary,
  onTertiary: darkGreyGreen,
  tertiaryContainer: tertiaryDark,
  onTertiaryContainer: white,
  error: Color(0xFFCF6679),
  errorContainer: Color(0xFFB00020),
  onError: darkGreyGreen,
  onErrorContainer: white,
  surface: darkGrey,
  onSurface: white,
  outline: grey,
  onInverseSurface: darkGreyGreen,
  inverseSurface: white,
  inversePrimary: primaryLight,
  shadow: Color(0xFF1A1A1A), // off black
  surfaceTint: primary,
  outlineVariant: grey,
  scrim: Color(0xFF1A1A1A), // off black
);

final TextTheme _darkTextTheme = TextTheme(
  // Main title, biggest boi
  displayLarge: appTextTheme.displayLarge?.copyWith(
    color: white,
  ),
  // less biggest boi
  displayMedium: appTextTheme.displayMedium?.copyWith(
    color: white,
  ),
  // not so big boi
  displaySmall: appTextTheme.displaySmall?.copyWith(
    color: white,
  ),
  // profile card and other large-ish titles
  titleLarge: appTextTheme.titleLarge?.copyWith(
    color: white,
  ),
  // FAQ page and other text titles
  titleMedium: appTextTheme.titleMedium?.copyWith(
    color: white,
  ),
  // Puzzle title on homepage and other smaller titles
  titleSmall: appTextTheme.titleSmall?.copyWith(
    color: white,
  ),
  // Profile name on leaderboard
  labelLarge: appTextTheme.labelLarge?.copyWith(
    color: white,
  ),
  // FAQ/Setting row titles
  labelMedium: appTextTheme.labelMedium?.copyWith(
    color: white,
  ),
  // tab navigation
  labelSmall: appTextTheme.labelSmall?.copyWith(
    color: white,
  ),
  bodyLarge: appTextTheme.bodyLarge?.copyWith(
    color: white,
  ),
  // typical body font
  bodyMedium: appTextTheme.bodyMedium?.copyWith(
    color: white,
  ),
  // little bois
  bodySmall: appTextTheme.bodySmall?.copyWith(
    color: white,
  ),
);

final darkTheme = ThemeData(
  colorScheme: _darkColors,
  useMaterial3: true,
  fontFamily: defaultFontFamily,
  textTheme: _darkTextTheme,
);
