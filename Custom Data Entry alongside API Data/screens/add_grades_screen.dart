import 'package:flutter/material.dart';
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

  final List<String> _courses = ['ICT', 'OOP', 'Networking', 'Database'];
  final List<String> _semesters = ['1', '2', '3', '4', '5', '6', '7', '8'];
  final List<String> _creditHoursList = ['1', '2', '3', '4', '5'];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Map<String, dynamic> newGrade = {
        'coursetitle': _courseName,
        'mysemester': _semester,
        'credithours': _creditHours,
        'obtainedmarks': _marks,
        // Baaki fields blank rahenge
        'studentname': '',
        'fathername': '',
        'progname': '',
        'shift': '',
        'rollno': '',
        'coursecode': '',
        'consider_status': '',
      };
      await dbHelper.insertStudent(newGrade);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Grade Added Successfully!')),
      );
      Navigator.pop(context); // Wapas HomeScreen pe jao
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Grades')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Course Name'),
                items: _courses.map((course) => DropdownMenuItem(value: course, child: Text(course))).toList(),
                onChanged: (value) => setState(() => _courseName = value),
                validator: (value) => value == null ? 'Please select a course' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Semester'),
                items: _semesters.map((sem) => DropdownMenuItem(value: sem, child: Text(sem))).toList(),
                onChanged: (value) => setState(() => _semester = value),
                validator: (value) => value == null ? 'Please select a semester' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Credit Hours'),
                items: _creditHoursList.map((ch) => DropdownMenuItem(value: ch, child: Text(ch))).toList(),
                onChanged: (value) => setState(() => _creditHours = value),
                validator: (value) => value == null ? 'Please select credit hours' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Course Marks'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _marks = value!,
                validator: (value) => value!.isEmpty ? 'Please enter marks' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}