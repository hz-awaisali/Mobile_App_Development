import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Text(
              'Grade App Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.blueAccent),
            title: Text('Home', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle, color: Colors.blueAccent),
            title: Text('Add Grades', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/addGrades');
            },
          ),
          ListTile(
            leading: Icon(Icons.cloud, color: Colors.blueAccent),
            title: Text('API Data', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/apiData');
            },
          ),
          ListTile(
            leading: Icon(Icons.cloud_upload, color: Colors.blueAccent),
            title: Text('Add Grades to API', style: TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/addGradesToApi');
            },
          ),
        ],
      ),
    );
  }
}