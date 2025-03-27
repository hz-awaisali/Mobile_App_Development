import 'package:flutter/material.dart';
import '../database_helper.dart';

class GpaScreen extends StatefulWidget {
  @override
  _GpaScreenState createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  final _dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _subjects = [];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    final subjects = await _dbHelper.getAllSubjects();
    setState(() {
      _subjects = subjects;
    });
  }

  double _calculateGpa() {
    if (_subjects.isEmpty) return 0.0;

    double totalPoints = 0.0;
    int totalCreditHours = 0;

    for (var subject in _subjects) {
      double percentage =
          (subject['obtainedMarks'] / subject['totalMarks']) * 100;
      double gradePoint;
      if (percentage >= 90)
        gradePoint = 4.0;
      else if (percentage >= 80)
        gradePoint = 3.0;
      else if (percentage >= 70)
        gradePoint = 2.0;
      else if (percentage >= 60)
        gradePoint = 1.0;
      else
        gradePoint = 0.0;

      totalPoints += gradePoint * subject['creditHours'];
      totalCreditHours += (subject['creditHours'] as int);
    }

    return totalCreditHours == 0 ? 0.0 : totalPoints / totalCreditHours;
  }

  void _editSubject(Map<String, dynamic> subject) {
    TextEditingController obtainedMarksController = TextEditingController(
      text: subject['obtainedMarks'].toString(),
    );
    TextEditingController totalMarksController = TextEditingController(
      text: subject['totalMarks'].toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Edit Subject: ${subject['subject']}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: obtainedMarksController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Obtained Marks'),
                ),
                TextField(
                  controller: totalMarksController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Total Marks'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  subject['obtainedMarks'] = double.parse(
                    obtainedMarksController.text,
                  );
                  subject['totalMarks'] = double.parse(
                    totalMarksController.text,
                  );
                  await _dbHelper.updateSubject(subject);
                  _loadSubjects();
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
    );
  }

  void _deleteSubject(int id) async {
    await _dbHelper.deleteSubject(id);
    _loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GPA Calculator')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'GPA: ${_calculateGpa().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          _subjects.isEmpty
              ? Center(child: Text('No subjects added'))
              : Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Subject')),
                      DataColumn(label: Text('Obt. Marks')),
                      DataColumn(label: Text('Total Marks')),
                      DataColumn(label: Text('Credits')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows:
                        _subjects.map((subject) {
                          return DataRow(
                            cells: [
                              DataCell(Text(subject['subject'])),
                              DataCell(
                                Text(subject['obtainedMarks'].toString()),
                              ),
                              DataCell(Text(subject['totalMarks'].toString())),
                              DataCell(Text(subject['creditHours'].toString())),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => _editSubject(subject),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed:
                                          () => _deleteSubject(subject['id']),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
