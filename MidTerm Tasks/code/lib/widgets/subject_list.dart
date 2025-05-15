import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectList extends StatelessWidget {
  final List<Subject> subjects;

  const SubjectList({Key? key, required this.subjects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enrolled Subjects',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                headingRowColor: MaterialStateProperty.all(
                  Colors.grey.shade100,
                ),
                border: TableBorder.all(
                  color: Colors.grey.shade300,
                  width: 1,
                  borderRadius: BorderRadius.circular(8),
                ),
                columns: const [
                  DataColumn(
                    label: Text(
                      'Subject Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Teacher',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Credit Hours',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    numeric: true,
                  ),
                ],
                rows: subjects.map((subject) {
                  return DataRow(
                    cells: [
                      DataCell(Text(subject.name)),
                      DataCell(Text(subject.teacherName)),
                      DataCell(Text(subject.creditHours.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}