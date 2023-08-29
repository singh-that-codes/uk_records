// ignore_for_file: library_private_types_in_public_api, unnecessary_cast

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myukapp/screens/criminal_details_screen.dart';
import 'package:myukapp/styles/app_colors.dart';
import 'package:myukapp/styles/styles.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Map<String, dynamic>> criminalsData = []; // Store all criminal data
  List<Map<String, dynamic>> filteredCriminals = []; // Store filtered criminal data

  @override
  void initState() {
    super.initState();
    _loadCriminals();
  }

  void _loadCriminals() {
    FirebaseFirestore.instance.collection('criminals').get().then((querySnapshot) {
      setState(() {
        criminalsData = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        filteredCriminals = criminalsData; // Initialize filtered list with all criminals
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar
      (title: const Text('Criminal List'),
      backgroundColor: AppColors.appBarColor,
      
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterCriminals,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  borderSide: BorderSide(
                    color: AppColors.ShadeColor,
                  )
                ),
                labelText: 'Search by Full Name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCriminals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredCriminals[index]['fullName'],
                    style: AppStyles.bodyStyle,),
                  subtitle: Text(
                    filteredCriminals[index]['summary'],
                    style: AppStyles.commonTextStyle,
                    
                    ),
                  leading: filteredCriminals[index]['image'] != null
                      ? Image.network(filteredCriminals[index]['image']) // Display the image
                      : const Icon(Icons.person), // Display default icon if no image
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CriminalDetailsScreen(
                          criminalDetails: filteredCriminals[index], // Pass selected criminal's details
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
