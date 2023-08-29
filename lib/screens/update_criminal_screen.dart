import 'package:flutter/material.dart';
import 'package:myukapp/firestore_database/database_service.dart';
import 'package:myukapp/screens/update_criminal_details_screen.dart';
import 'package:myukapp/styles/app_colors.dart'; // Import the update details screen

class UpdateCriminalScreen extends StatefulWidget {
  const UpdateCriminalScreen({Key? key}) : super(key: key);

  @override
  _UpdateCriminalScreenState createState() => _UpdateCriminalScreenState();
}

class _UpdateCriminalScreenState extends State<UpdateCriminalScreen> {
  late List<Map<String, dynamic>> criminalsData;
  late List<Map<String, dynamic>> filteredCriminals;
  late String selectedCriminal = '';

  @override
  void initState() {
    super.initState();
    _loadCriminals();
  }

  void _loadCriminals() {
    criminalsData = [];
    filteredCriminals = []; // Initialize with empty list

    DatabaseService().getCriminals().listen((criminalNames) {
      setState(() {
        criminalsData = criminalNames
            .map((name) => {'fullName': name})
            .toList();
        filteredCriminals = criminalsData; // Initialize with all criminals
      });
    });
  }

  void _filterCriminals(String query) {
    setState(() {
      filteredCriminals = criminalsData
          .where((criminal) => criminal['fullName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onCriminalSelected(String criminalName) {
    setState(() {
      selectedCriminal = criminalName;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateCriminalDetailsScreen(criminalName: selectedCriminal, selectedCriminal: '',), // Pass selected criminal name
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: const Text('Update Criminal')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterCriminals,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search Criminal by Name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCriminals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredCriminals[index]['fullName']),
                  onTap: () => _onCriminalSelected(filteredCriminals[index]['fullName']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
