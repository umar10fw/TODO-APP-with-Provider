import 'package:flutter/material.dart';

import '../../core/constant/color.dart';


class AppTheme {
  static const String fontFamily = 'Poppins'; // or 'Inter'

  // 🌤 LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: fontFamily,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textLight,
      background: AppColors.backgroundLight,
      onBackground: AppColors.textLight,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textLight,
      error: AppColors.error,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
    ),
  );

  // 🌙 DARK THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: fontFamily,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      onPrimary: Colors.white,
      secondary: AppColors.secondaryDark,
      onSecondary: Colors.white70,
      background: AppColors.backgroundDark,
      onBackground: AppColors.textDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textDark,
      error: AppColors.error,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      bodyLarge: TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
    ),
  );
}