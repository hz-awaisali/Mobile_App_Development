import 'package:flutter/material.dart';

// App theme colors
class AppColors {
  static const Color primary = Color(0xFF1976D2);
  static const Color secondary = Color(0xFF03A9F4);
  static const Color accent = Color(0xFF00BCD4);
  static const Color background = Color(0xFFF5F5F5);
  static const Color card = Colors.white;
  static const Color error = Color(0xFFD32F2F);
}

// API URLs
class ApiUrls {
  static const String baseUrl = "https://awaisali.pythonanywhere.com";
  static const String studentsEndpoint = "$baseUrl/api/students/";
}

// Database constants
class DatabaseConstants {
  static const String dbName = 'awais_ali_app.db';
  static const String notesTable = 'notes';
  static const int dbVersion = 1;
}

// App texts
class AppTexts {
  static const String appName = 'Awais Ali';
  static const String homeTitle = 'Home';
  static const String storageTitle = 'Local Storage';
  static const String apiTitle = 'API Data';
}

// App routes
class AppRoutes {
  static const String home = '/';
  static const String storage = '/storage';
  static const String api = '/api';
}