import 'package:flutter/material.dart';
import 'utils/constants.dart';

class AppConfig {
  // App theme
  static ThemeData get theme => ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          error: AppColors.error,
          background: AppColors.background,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: AppColors.card,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        useMaterial3: true,
      );

  // Sample subjects data
  static List<Map<String, dynamic>> getSampleSubjects() {
    return [
      {
        'id': 1,
        'name': 'Artificial Intelligence',
        'teacherName': 'Sir Shahzad Nazir',
        'creditHours': 5.0,
      },
      {
        'id': 2,
        'name': 'Mobile App Development',
        'teacherName': 'Sir Nabeel Akram',
        'creditHours': 5.0,
      },
      {
        'id': 3,
        'name': 'Information Security',
        'teacherName': 'Mam Kashifa',
        'creditHours': 3.0,
      },
      {
        'id': 4,
        'name': 'Compiler Construction',
        'teacherName': 'Sir Hassan Iftikhar',
        'creditHours': 3.0,
      },
      {
        'id': 5,
        'name': 'Database Management Systems',
        'teacherName': 'Sir Khalid',
        'creditHours': 5.0,
      },
    ];
  }
}