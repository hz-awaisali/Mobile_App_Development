import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../database/database_helper.dart';

class AddGradesScreen extends StatefulWidget {
  @override
  _AddGradesScreenState createState() => _AddGradesScreenState();
}

class _AddGradesScreenState extends State<AddGradesScreen> {
  final _formKey = GlobalKey<FormState>();
  final dbHelper = DatabaseHelper.instance;

  String? _courseName;
  String? _semester;
  String? _creditHours;
  String _marks = '';
  List<Map<String, dynamic>> _courses = [];
  bool _isLoadingCourses = true;
  bool _showSuccessMessage = false;

  final List<String> _semesters = ['1', '2', '3', '4', '5', '6', '7', '8'];
  final List<String> _creditHoursList = ['1', '2', '3', '4', '5'];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  Future<void> _fetchCourses() async {
    try {
      final response = await http.get(Uri.parse('https://bgnuerp.online/api/get_courses'));
      if (response.statusCode == 200) {
        setState(() {
          _courses = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          _isLoadingCourses = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load courses'), backgroundColor: Colors.red),
        );
        setState(() => _isLoadingCourses = false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
      setState(() => _isLoadingCourses = false);
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, dynamic> newGrade = {
        'coursetitle': _courseName,
        'mysemester': _semester,
        'credithours': _creditHours,
        'obtainedmarks': _marks,
        'studentname': '',
        'fathername': '',
        'progname': '',
        'shift': '',
        'rollno': '',
        'coursecode': '',
        'consider_status': '',
      };
      await dbHelper.insertStudent(newGrade);
      setState(() {
        _showSuccessMessage = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _showSuccessMessage = false;
        });
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grade Management', style: TextStyle(color: Colors.white)),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add New Grade',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              SizedBox(height: 10),
              if (_showSuccessMessage)
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Grade added successfully', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              if (_showSuccessMessage) SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _isLoadingCourses
                        ? Center(child: CircularProgressIndicator())
                        : Autocomplete<Map<String, dynamic>>(
                            optionsBuilder: (TextEditingValue textEditingValue) {
                              if (textEditingValue.text.isEmpty) {
                                return _courses;
                              }
                              return _courses.where((course) => (course['subject_name'] as String)
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase()));
                            },
                            displayStringForOption: (Map<String, dynamic> option) =>
                                '${option['subject_code']} - ${option['subject_name']}',
                            onSelected: (Map<String, dynamic> selection) {
                              setState(() => _courseName = selection['subject_name']);
                            },
                            fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                              return TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  labelText: 'Course',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.book, color: Colors.blueAccent),
                                ),
                                validator: (value) =>
                                    value!.isEmpty || !_courses.any((c) => c['subject_name'] == _courseName)
                                        ? 'Select a valid course'
                                        : null,
                              );
                            },
                          ),
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Semester Number',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.calendar_today, color: Colors.blueAccent),
                      ),
                      items: _semesters.map((sem) => DropdownMenuItem(value: sem, child: Text(sem))).toList(),
                      onChanged: (value) => setState(() => _semester = value),
                      validator: (value) => value == null ? 'Select a semester' : null,
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Credit Hours',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.access_time, color: Colors.blueAccent),
                      ),
                      items: _creditHoursList.map((ch) => DropdownMenuItem(value: ch, child: Text(ch))).toList(),
                      onChanged: (value) => setState(() => _creditHours = value),
                      validator: (value) => value == null ? 'Select credit hours' : null,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Marks',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.bar_chart, color: Colors.blueAccent),
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _marks = value!,
                      validator: (value) => value!.isEmpty ? 'Enter marks' : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _submitForm,
                      icon: Icon(Icons.check, color: Colors.white),
                      label: Text('Submit Grade', style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}