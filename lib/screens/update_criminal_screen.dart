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
      appBar: AppBar(title: Text('Update Criminal')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: _filterCriminals,
              decoration: InputDecoration(labelText: 'Search Criminal'),
            ),
            SizedBox(height: 10),
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
              SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedField,
                onChanged: (value) {
                  setState(() {
                    _selectedField = value!;
                  });
                },
                items: <String>[
                  'fullName', // Add other field names here
                  'fathersname',
                  'mothersname',
                  // Add more fields
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Select Field to Update'),
              ),
              SizedBox(height: 10),
              if (_selectedField.isNotEmpty) ...[
                TextField(
                  controller: _newValueController,
                  decoration: InputDecoration(
                    labelText: 'New Value for $_selectedField',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String newValue = _newValueController.text;
                    await DatabaseService().updateCriminalField(
                      _selectedCriminalKey,
                      _selectedField,
                      newValue,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Criminal record updated')),
                    );

                    _selectedCriminalKey = '';
                    _selectedField = '';
                    _newValueController.clear();
                  },
                  child: Text('Update Criminal'),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
