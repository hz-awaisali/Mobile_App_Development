import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../database/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> students = [];

  Future<void> _loadLocalData() async {
    final data = await dbHelper.getStudents();
    setState(() {
      students = data;
    });
  }

  Future<void> _fetchAndStoreData() async {
    final response = await http.get(Uri.parse('https://bgnuerp.online/api/gradeapi'));
    if (response.statusCode == 200) {
      List<dynamic> apiData = jsonDecode(response.body);
      for (var student in apiData) {
        await dbHelper.insertStudent(student);
      }
      await _loadLocalData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data Loaded Successfully'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _clearData() async {
    await dbHelper.clearStudents();
    setState(() {
      students = [];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data Cleared Successfully'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Grades', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text('Grade App Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text('Add Grades'),
              onTap: () => Navigator.pushReplacementNamed(context, '/addGrades'),
            ),
            ListTile(
              leading: Icon(Icons.cloud),
              title: Text('API Data'),
              onTap: () => Navigator.pushReplacementNamed(context, '/apiData'),
            ),
            ListTile(
              leading: Icon(Icons.cloud_upload),
              title: Text('Add Grades to API'),
              onTap: () => Navigator.pushReplacementNamed(context, '/addGradesToApi'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _fetchAndStoreData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: Text('Load Data', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: _clearData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: Text('Clear Data', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/addGrades').then((_) => _loadLocalData()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  child: Text('Add Grades', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: students.isEmpty
                  ? Center(child: Text('No Data Available', style: TextStyle(fontSize: 18, color: Colors.grey)))
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 15,
                          border: TableBorder.all(color: Colors.grey.shade300),
                          columns: [
                            DataColumn(label: Text('Student', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Father', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Program', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Shift', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Roll No', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Code', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Course', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Credits', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Marks', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Sem', style: TextStyle(fontWeight: FontWeight.bold))),
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
          ],
        ),
      ),
    );
  }
}