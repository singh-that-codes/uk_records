// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:myukapp/firestore_database/database_service.dart';

class AddCriminalScreen extends StatefulWidget {
  const AddCriminalScreen({super.key});

  @override
  _AddCriminalScreenState createState() => _AddCriminalScreenState();
}

class _AddCriminalScreenState extends State<AddCriminalScreen> {
  final picker = ImagePicker();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _criminalRecordController = TextEditingController();
  final TextEditingController _fathersNameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  File? _image;
  Uint8List? _imageBytes;
  final TextEditingController _mothersNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _relatedRecordsController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _image = File(pickedFile.path);
        _imageBytes = Uint8List.fromList(imageBytes);
      });
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      // Upload the image to Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}.jpg');
      UploadTask uploadTask = storageReference.putFile(image);

      // Get the download URL
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      return imageUrl;
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
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

    // Perform the necessary actions to add the criminal to the database
    // For example:
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

    // Clear text controllers and image
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
      const SnackBar(content: Text('Criminal added successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('Add New Criminal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name')
              ),
              TextField(controller: _fathersNameController,
                decoration: const InputDecoration(labelText: "Father's Name")
              ),
              TextField(controller: _mothersNameController, decoration: const InputDecoration(labelText: "Mother's Name")),
              TextField(controller: _ageController, decoration: const InputDecoration(labelText: 'Age')),
              TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
              TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone')),
              TextField(controller: _criminalRecordController, decoration: const InputDecoration(labelText: 'Criminal Record')),
              TextField(controller: _relatedRecordsController, decoration: const InputDecoration(labelText: 'Related Records')),
              TextField(controller: _summaryController, decoration: const InputDecoration(labelText: 'Summary')),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _pickImage, child: const Text('Upload Image')),
              if (_imageBytes != null) ...[
                const SizedBox(height: 10),
                Image.memory(_imageBytes!),
              ],
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _addCriminal, child: const Text('Add Criminal')),
            ],
          ),
        ),
      ),
    );
  }
}
