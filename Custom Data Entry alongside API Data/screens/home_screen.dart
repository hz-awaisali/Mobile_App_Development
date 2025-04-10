import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../database/database_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    _loadLocalData();
  }

  Future<void> _loadLocalData() async {
    final data = await dbHelper.getStudents();
    setState(() {
      students = data;
    });
  }

  Future<void> _fetchAndStoreData() async {
    try {
      final response = await http.get(Uri.parse('https://bgnuerp.online/api/gradeapi'));
      if (response.statusCode == 200) {
        List<dynamic> apiData = jsonDecode(response.body);
        for (var student in apiData) {
          await dbHelper.insertStudent(student);
        }
        await _loadLocalData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data Loaded Successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data from API')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _clearData() async {
    await dbHelper.clearStudents();
    setState(() {
      students = [];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data Cleared Successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Grades'),
        actions: [
          ElevatedButton(
            onPressed: _fetchAndStoreData,
            child: Text('Load Data'),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: _clearData,
            child: Text('Clear Data'),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/addGrades').then((_) => _loadLocalData()),
            child: Text('Add Grades'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: students.isEmpty
          ? Center(child: Text('No Data Available', style: TextStyle(fontSize: 18)))
          : Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columnSpacing: 20,
                    columns: [
                      DataColumn(label: Text('Student', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Father', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Program', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Shift', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Roll No', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Course Code', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Course Title', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Credits', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Marks', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Semester', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: students.map((student) => DataRow(cells: [
                      DataCell(Text(student['studentname'] ?? '')),
                      DataCell(Text(student['fathername'] ?? '')),
                      DataCell(Text(student['progname'] ?? '')),
                      DataCell(Text(student['shift'] ?? '')),
                      DataCell(Text(student['rollno'] ?? '')),
                      DataCell(Text(student['coursecode'] ?? '')),
                      DataCell(Text(student['coursetitle'] ?? '')),
                      DataCell(Text(student['credithours'] ?? '')),
                      DataCell(Text(student['obtainedmarks'] ?? '')),
                      DataCell(Text(student['mysemester'] ?? '')),
                      DataCell(Text(student['consider_status'] ?? '')),
                    ])).toList(),
                  ),
                ),
              ),
            ),
    );
  }
}