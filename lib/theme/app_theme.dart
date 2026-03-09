import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF64FFDA); // Teal/Cyan accent
  static const Color backgroundColor = Color(0xFF0A192F); // Deep Navy
  static const Color scaffoldBackgroundColor = Colors.transparent;
  static const Color cardColor = Color(0xFF112240);
  static const Color textColor = Color(0xFFCCD6F6);
  static const Color textSecondaryColor = Color(0xFF8892B0);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: primaryColor,
      surface: cardColor,
      background: backgroundColor,
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        bodyLarge: TextStyle(fontSize: 18, color: textColor, height: 1.6),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: textSecondaryColor,
          height: 1.5,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
    ),
  );
}
