import 'package:flutter/material.dart';
import 'app_config.dart';
import 'screens/home_screen.dart';
import 'screens/storage_screen.dart';
import 'screens/api_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTexts.appName,
      theme: AppConfig.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.storage: (context) => const StorageScreen(),
        AppRoutes.api: (context) => const ApiScreen(),
      },
    );
  }
}