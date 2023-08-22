// ignore_for_file: unused_field, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myukapp/firestore_database/database_service.dart';

class UpdateCriminalScreen extends StatefulWidget {
  @override
  _UpdateCriminalScreenState createState() => _UpdateCriminalScreenState();
}

class _UpdateCriminalScreenState extends State<UpdateCriminalScreen> {
  String _searchQuery = '';
  String _selectedCriminalKey = '';
  String _selectedField = '';
  TextEditingController _newValueController = TextEditingController();

  List<String> _filteredCriminals = [];

  void _filterCriminals(String query) {
    DatabaseService().getCriminals().listen((criminals) {
      setState(() {
        _filteredCriminals = criminals
            .where((criminal) =>
                criminal.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    });
  }

  void _updateSelectedCriminal(String criminalKey) {
    setState(() {
      _selectedCriminalKey = criminalKey;
      _searchQuery = '';
      _filteredCriminals.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Criminal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: _filterCriminals,
              decoration: const InputDecoration(labelText: 'Search Criminal'),
            ),
            const SizedBox(height: 10),
            if (_filteredCriminals.isNotEmpty)
              Column(
                children: _filteredCriminals.map((criminalKey) {
                  return ListTile(
                    title: Text(criminalKey),
                    onTap: () => _updateSelectedCriminal(criminalKey),
                  );
                }).toList(),
              ),
            if (_selectedCriminalKey.isNotEmpty) ...[
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedField,
                onChanged: (value) {
                  setState(() {
                    _selectedField = value!;
                  });
                },
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'fullName',
                    child: Text('Full Name'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'fathersname',
                    child: Text("Father's Name"),
                  ),
                  DropdownMenuItem<String>(
                    value: 'mothersname',
                    child: Text("Mother's Name"),
                  ),
                  DropdownMenuItem<String>(
                    value: 'age',
                    child: Text("Age"),
                  ),
                  DropdownMenuItem<String>(
                    value: 'address',
                    child: Text("Address"),
                  ),
                  DropdownMenuItem<String>(
                    value: 'phone',
                    child: Text("Phone"),
                  ),
                  DropdownMenuItem<String>(
                    value: 'criminalRecord',
                    child: Text("Criminal Record"),
                  ),
                  DropdownMenuItem<String>(
                    value: 'relatedRecords',
                    child: Text("Related Records"),
                  ),
                  DropdownMenuItem<String>(
                    value: 'summary',
                    child: Text("Summary"),
                  ),
                  DropdownMenuItem<String>(
                    value: 'imaggeurl',
                    child: Text("Image"),
                  ),

                  // Add more field names here
                ],
                hint: const Text('Select Field to Update'),
              ),
              const SizedBox(height: 10),
              if (_selectedField.isNotEmpty) ...[
                TextField(
                  controller: _newValueController,
                  decoration: InputDecoration(
                    labelText: 'New Value for $_selectedField',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String newValue = _newValueController.text;
                    await DatabaseService().updateCriminalField(
                      _selectedCriminalKey,
                      _selectedField,
                      newValue,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Criminal record updated')),
                    );

                    setState(() {
                      _selectedCriminalKey = '';
                      _selectedField = '';
                      _newValueController.clear();
                    });
                  },
                  child: const Text('Update Criminal'),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
