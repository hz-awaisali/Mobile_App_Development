import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/app_drawer.dart'; // Import the shared Drawer

class ApiDataScreen extends StatefulWidget {
  @override
  _ApiDataScreenState createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  List<dynamic> apiData = [];
  List<dynamic> filteredData = [];
  bool isLoading = true;
  // ignore: unused_field
  String _userId = '';

  Future<void> _fetchApiData() async {
    setState(() => isLoading = true);
    try {
      final url = Uri.parse('https://devtechtop.com/management/public/api/select_data');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var rawData = jsonDecode(response.body);
        List<dynamic> fetchedData = [];
        if (rawData is List) {
          fetchedData = rawData;
        } else if (rawData is Map && rawData.containsKey('data')) {
          fetchedData = rawData['data'] ?? [];
        } else if (rawData is Map) {
          fetchedData = [rawData];
        }
        setState(() {
          apiData = fetchedData;
          filteredData = fetchedData;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data: ${response.statusCode}'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void _filterData(String userId) {
    setState(() {
      _userId = userId;
      if (userId.isEmpty) {
        filteredData = apiData;
      } else {
        filteredData = apiData.where((data) => data['user_id'] == userId).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchApiData();
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
                  'Fetch Grades by User ID',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'User ID (Optional)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                  ),
                  onChanged: _filterData,
                ),
                SizedBox(height: 20),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else if (filteredData.isEmpty)
                  Center(child: Text('No Data Available', style: TextStyle(fontSize: 18, color: Colors.grey)))
                else
                  Column(
                    children: filteredData.map((data) {
                      int marks = int.tryParse(data['marks'] ?? '0') ?? 0;
                      double gradePoint = marks >= 90
                          ? 4.0
                          : marks >= 80
                              ? 3.7
                              : marks >= 70
                                  ? 3.3
                                  : marks >= 60
                                      ? 3.0
                                      : marks >= 50
                                          ? 2.0
                                          : 0.0;
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data['course_name'] ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'User ID: ${data['user_id'] ?? ''}',
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Semester: ${data['semester_no']?.toString() ?? ''}',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(
                                    'Credits: ${data['credit_hours']?.toString() ?? ''}',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Marks: ${data['marks']?.toString() ?? ''}',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  Text(
                                    'GPA: ${gradePoint.toStringAsFixed(1)}',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addGradesToApi').then((_) => _fetchApiData()),
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}