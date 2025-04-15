import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          ListTile(
            leading: Icon(Icons.task),
            title: Text('Tasks'),
            onTap: () => Navigator.pushReplacementNamed(context, '/tasks'),
          ),
        ],
      ),
    );
  }
}