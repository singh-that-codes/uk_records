import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Map<String, dynamic>> criminalsData = []; // Store all criminal data

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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criminal List')),
      body: ListView.builder(
        itemCount: criminalsData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(criminalsData[index]['fullName']),
            subtitle: Text(criminalsData[index]['summary']),
            leading: criminalsData[index]['image'] != null
                ? Image.network(criminalsData[index]['image']) // Display the image
                : Icon(Icons.person), // Display default icon if no image
          );
        },
      ),
    );
  }
}
