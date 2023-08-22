import 'package:flutter/material.dart';
import 'package:myukapp/screens/add_criminal_screen.dart';
import 'package:myukapp/screens/list_screen.dart';
import 'package:myukapp/screens/update_criminal_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListScreen()),
                );
              },
              child: Text('Search for a Criminal'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCriminalScreen()),
                );
              },
              child: Text('Add New Criminal'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateCriminalScreen()),
                );
              },
              child: Text('Update Criminal Records'),
            ),
          ],
        ),
      ),
    );
  }
}
