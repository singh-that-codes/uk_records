// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:myukapp/firestore_database/database_service.dart';
import 'package:myukapp/styles/app_colors.dart';

class UpdateCriminalDetailsScreen extends StatefulWidget {
  final String selectedCriminal;

  const UpdateCriminalDetailsScreen({Key? key, required this.selectedCriminal, required String criminalName})
      : super(key: key);

  @override
  _UpdateCriminalDetailsScreenState createState() =>
      _UpdateCriminalDetailsScreenState();
}

class _UpdateCriminalDetailsScreenState
    extends State<UpdateCriminalDetailsScreen> {
      
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _fathersNameController = TextEditingController();
  final TextEditingController _mothersNameController = TextEditingController();
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
    _fullNameController.text = criminalDetails['fullName'] ?? "";
    _fathersNameController.text=criminalDetails['fathersname'] ?? "";
    _mothersNameController.text=criminalDetails['mothersname'] ?? "";
    _criminalRecordsController.text=criminalDetails['criminalRecords'] ?? "";
    _relatedRecordsController.text=criminalDetails['relatedrecords'] ?? "";
    _imageUrlController.text=criminalDetails['imageurl'] ?? "";
    _ageController.text = criminalDetails['age'] ?? "";
    _phoneController.text=criminalDetails['phone'] ?? "";
    _summaryController.text=criminalDetails['summary'] ?? "";
    _addressController.text = criminalDetails['address'] ?? "";
    
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: const Text('Update Criminal Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _fathersNameController,
              decoration: const InputDecoration(labelText: 'Father\'s Name'),
            ),
            TextField(
              controller: _mothersNameController,
              decoration: const InputDecoration(labelText: 'Mother\'s Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _criminalRecordsController,
              decoration: const InputDecoration(labelText: 'Criminal Records'),
            ),
            TextField(
              controller: _relatedRecordsController,
              decoration: const InputDecoration(labelText: 'Related Records'),
            ),
            TextField(
              controller: _summaryController,
              decoration: const InputDecoration(labelText: 'Summary'),
            ),
            
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
                );

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
    _fathersNameController.dispose();
    _mothersNameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _criminalRecordsController.dispose();
    _relatedRecordsController.dispose();
    _summaryController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
