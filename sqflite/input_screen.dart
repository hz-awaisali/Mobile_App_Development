import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'gpa_screen.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _obtainedMarksController = TextEditingController();
  final _totalMarksController = TextEditingController();
  final _dbHelper = DatabaseHelper.instance;

  String? _selectedSubject;
  int? _selectedCreditHours;
  final List<String> _subjects = ['Math', 'Science', 'English', 'History', 'Art'];
  final List<int> _creditHours = [1, 2, 3, 4];

  void _submitForm() async {
    if (_selectedSubject != null &&
        _obtainedMarksController.text.isNotEmpty &&
        _totalMarksController.text.isNotEmpty &&
        _selectedCreditHours != null) {
      Map<String, dynamic> subject = {
        'subject': _selectedSubject,
        'obtainedMarks': double.parse(_obtainedMarksController.text),
        'totalMarks': double.parse(_totalMarksController.text),
        'creditHours': _selectedCreditHours,
      };

      await _dbHelper.insertSubject(subject);

      _obtainedMarksController.clear();
      _totalMarksController.clear();
      _selectedSubject = null;
      _selectedCreditHours = null;

      setState(() {}); // Reset dropdowns

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Subject added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Subject')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Select Subject'),
              value: _selectedSubject,
              onChanged: (value) {
                setState(() {
                  _selectedSubject = value;
                });
              },
              items: _subjects.map((subject) {
                return DropdownMenuItem(value: subject, child: Text(subject));
              }).toList(),
            ),
            TextField(
              controller: _obtainedMarksController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Obtained Marks'),
            ),
            TextField(
              controller: _totalMarksController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Total Marks'),
            ),
            DropdownButton<int>(
              hint: Text('Select Credit Hours'),
              value: _selectedCreditHours,
              onChanged: (value) {
                setState(() {
                  _selectedCreditHours = value;
                });
              },
              items: _creditHours.map((hours) {
                return DropdownMenuItem(value: hours, child: Text('$hours'));
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GpaScreen()),
                );
              },
              child: Text('View GPA'),
            ),
          ],
        ),
      ),
    );
  }
}