import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/add_grades_screen.dart';
import './screens/api_data_screen.dart';
import './screens/add_grades_to_api_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/addGrades': (context) => AddGradesScreen(),
        '/apiData': (context) => ApiDataScreen(),
        '/addGradesToApi': (context) => AddGradesToApiScreen(),
      },
    );
  }
}