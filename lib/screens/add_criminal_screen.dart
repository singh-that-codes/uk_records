import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myukapp/firestore_database/database_service.dart'; // Import DatabaseService

class AddCriminalScreen extends StatefulWidget {
  @override
  _AddCriminalScreenState createState() => _AddCriminalScreenState();
}

class _AddCriminalScreenState extends State<AddCriminalScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _fathersNameController = TextEditingController();
  TextEditingController _mothersNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _criminalRecordController = TextEditingController();
  TextEditingController _relatedRecordsController = TextEditingController();
  TextEditingController _summaryController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadImage(File image) async {
    // Replace this with your actual image upload logic
    // Upload the image to your storage service and return the image URL
    return 'https://example.com/image.jpg';
  }

  void _addCriminal() async {
    String fullName = _fullNameController.text;
    String fathersName = _fathersNameController.text;
    String mothersName = _mothersNameController.text;
    String age = _ageController.text;
    String address = _addressController.text;
    String phone = _phoneController.text;
    String criminalRecord = _criminalRecordController.text;
    String relatedRecords = _relatedRecordsController.text;
    String summary = _summaryController.text;

    String imageUrl = '';

    if (_image != null) {
      imageUrl = await uploadImage(_image!);
    }

    await DatabaseService().addCriminal(
      fullName: fullName,
      fathersname: fathersName,
      mothersName: mothersName,
      age: age,
      address: address,
      phone: phone,
      criminalRecord: criminalRecord,
      relatedRecords: relatedRecords,
      summary: summary,
      imageUrl: imageUrl,
    );

    _fullNameController.clear();
    _fathersNameController.clear();
    _mothersNameController.clear();
    _ageController.clear();
    _addressController.clear();
    _phoneController.clear();
    _criminalRecordController.clear();
    _relatedRecordsController.clear();
    _summaryController.clear();

    setState(() {
      _image = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Criminal added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Criminal')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(controller: _fullNameController, decoration: InputDecoration(labelText: 'Full Name')),
              TextField(controller: _fathersNameController, decoration: InputDecoration(labelText: "Father's Name")),
              TextField(controller: _mothersNameController, decoration: InputDecoration(labelText: "Mother's Name")),
              TextField(controller: _ageController, decoration: InputDecoration(labelText: 'Age')),
              TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Address')),
              TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone')),
              TextField(controller: _criminalRecordController, decoration: InputDecoration(labelText: 'Criminal Record')),
              TextField(controller: _relatedRecordsController, decoration: InputDecoration(labelText: 'Related Records')),
              TextField(controller: _summaryController, decoration: InputDecoration(labelText: 'Summary')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _pickImage, child: Text('Pick Image')),
              if (_image != null) ...[
                SizedBox(height: 10),
                Image.file(_image!),
              ],
              SizedBox(height: 20),
              ElevatedButton(onPressed: _addCriminal, child: Text('Add Criminal')),
            ],
          ),
        ),
      ),
    );
  }
}
