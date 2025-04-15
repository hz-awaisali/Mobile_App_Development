import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/app_drawer.dart'; // Import the shared Drawer

class AddGradesToApiScreen extends StatefulWidget {
  @override
  _AddGradesToApiScreenState createState() => _AddGradesToApiScreenState();
}

class _AddGradesToApiScreenState extends State<AddGradesToApiScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userId = '';
  String _courseName = '';
  String? _semesterNo;
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

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.parse(
        'https://devtechtop.com/management/public/api/grades?'
        'user_id=${Uri.encodeComponent(_userId)}'
        '&course_name=${Uri.encodeComponent(_courseName)}'
        '&semester_no=${Uri.encodeComponent(_semesterNo!)}'
        '&credit_hours=${Uri.encodeComponent(_creditHours!)}'
        '&marks=${Uri.encodeComponent(_marks)}',
      );
      try {
        final response = await http.get(url);
        var responseBody = jsonDecode(response.body);
        if (response.statusCode == 200 && responseBody['message'] == 'Grade inserted successfully') {
          setState(() {
            _showSuccessMessage = true;
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _showSuccessMessage = false;
            });
            Navigator.pop(context);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add grade: ${responseBody['message'] ?? response.body}'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grade Management', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: AppDrawer(), // Use the shared Drawer
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
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
                      border: Border.all(color: Colors.green),
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
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'User ID',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.grey[100],
                              prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                            ),
                            onSaved: (value) => _userId = value!,
                            validator: (value) => value!.isEmpty ? 'Enter User ID' : null,
                          ),
                          SizedBox(height: 15),
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
                                        fillColor: Colors.grey[100],
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
                              fillColor: Colors.grey[100],
                              prefixIcon: Icon(Icons.calendar_today, color: Colors.blueAccent),
                            ),
                            items: _semesters
                                .map((sem) => DropdownMenuItem(value: sem, child: Text(sem)))
                                .toList(),
                            onChanged: (value) => setState(() => _semesterNo = value),
                            validator: (value) => value == null ? 'Select a semester' : null,
                          ),
                          SizedBox(height: 15),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Credit Hours',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.grey[100],
                              prefixIcon: Icon(Icons.access_time, color: Colors.blueAccent),
                            ),
                            items: _creditHoursList
                                .map((ch) => DropdownMenuItem(value: ch, child: Text(ch)))
                                .toList(),
                            onChanged: (value) => setState(() => _creditHours = value),
                            validator: (value) => value == null ? 'Select credit hours' : null,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Marks',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.grey[100],
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
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}