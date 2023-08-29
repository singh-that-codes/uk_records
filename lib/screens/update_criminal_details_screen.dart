import 'package:flutter/material.dart';
import 'package:myukapp/firestore_database/database_service.dart';

class UpdateCriminalDetailsScreen extends StatefulWidget {
  final String selectedCriminal;

  const UpdateCriminalDetailsScreen({Key? key, required this.selectedCriminal})
      : super(key: key);

  @override
  _UpdateCriminalDetailsScreenState createState() =>
      _UpdateCriminalDetailsScreenState();
}

class _UpdateCriminalDetailsScreenState
    extends State<UpdateCriminalDetailsScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _fathersNameController = TextEditingController();
  TextEditingController _mothersNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _criminalRecordsController = TextEditingController();
  TextEditingController _relatedRecordsController = TextEditingController();
  TextEditingController _summaryController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  // Add more controllers for other fields

  @override
  void initState() {
    super.initState();
    _loadCriminalDetails();
  }

  void _loadCriminalDetails() async {
  Map<String, dynamic> criminalDetails =
      await DatabaseService().getCriminalDetails(widget.selectedCriminal);

  setState(() {
    _fullNameController.text = criminalDetails['fullName'];
    _fathersNameController.text=criminalDetails['fathersname']
    _ageController.text = criminalDetails['age'];
    _addressController.text = criminalDetails['address'];

    
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Criminal Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            // Add more TextFields for other fields
            ElevatedButton(
              onPressed: () {
                String newName = _fullNameController.text;
                String newAge = _ageController.text;
                String newAddress = _addressController.text;
                String newFathersName= _fathersNameController.text;
                String newMothersName = _fathersNameController.text;
                String newPhone = _phoneController.text;
                String newCriminalRecord = _criminalRecordsController.text;
                String newRelatedRecords = _relatedRecordsController.text;
                String newSummary = _summaryController.text;
                String newImageUrl = _imageUrlController.text;

                // Get new values from other TextFields

                // Update the criminal's details in the database
                DatabaseService().updateCriminalDetails(
                  widget.selectedCriminal,
                  newName,
                  newFathersName,
                  newMothersName,
                  newAge,
                  newAddress,
                  newPhone,
                  newCriminalRecord,
                  newRelatedRecords,
                  newSummary,
                  newImageUrl,
                  // Pass new values for other fields
                );

                // Show a success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Criminal details updated successfully')),
                );
              },
              child: const Text('Update Details'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    // Dispose other controllers

    super.dispose();
  }
}
