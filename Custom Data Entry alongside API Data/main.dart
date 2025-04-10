import 'package:flutter/material.dart';
import './screens/home_screen.dart';
import './screens/add_grades_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/addGrades': (context) => AddGradesScreen(),
      },
    );
  }
}