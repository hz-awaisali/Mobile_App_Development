import 'package:flutter/material.dart';
import '../database_helper.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final _dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final users = await _dbHelper.getAllUsers();
    setState(() {
      _users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Records')),
      body: _users.isEmpty
          ? Center(child: Text('No users found'))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Password')),
                ],
                rows: _users.map((user) {
                  return DataRow(cells: [
                    DataCell(Text(user['id'].toString())),
                    DataCell(Text(user['email'])),
                    DataCell(Text(user['password'])),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}