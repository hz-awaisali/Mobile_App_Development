import 'package:flutter/material.dart';
import 'package:second_flutter_app/widgets/drawer.dart';

class DataIterations01 extends StatelessWidget {
  const DataIterations01({super.key});

  static List<Map<String, dynamic>> students = [
    {"id": 1, "name": "John Doe", "age": 20, "grade": "A"},
    {"id": 2, "name": "Jane Smith", "age": 22, "grade": "B"},
    {"id": 3, "name": "Sam Brown", "age": 19, "grade": "A"},
    {"id": 4, "name": "Lisa Johnson", "age": 21, "grade": "C"},
    {"id": 5, "name": "Paul Davis", "age": 23, "grade": "B"},
    {"id": 6, "name": "Emily White", "age": 20, "grade": "A"},
    {"id": 7, "name": "Michael Green", "age": 22, "grade": "C"},
    {"id": 8, "name": "Sarah Black", "age": 19, "grade": "B"},
    {"id": 9, "name": "David Wilson", "age": 21, "grade": "A"},
    {"id": 10, "name": "Laura Martinez", "age": 23, "grade": "C"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iterations using ListView builder")),
      drawer: MyDrawer(),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            width: 100,
            child: Card(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "${students[index]["name"]}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Age : ${students[index]["age"].toString()}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Grade: ${students[index]["grade"].toString()}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "ID: ${students[index]["id"].toString()}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
