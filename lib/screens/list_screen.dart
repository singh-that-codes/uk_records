import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<String> filteredCriminals = [];
  TextEditingController _searchController = TextEditingController();

  void _filterCriminals(String query) {
    setState(() {
      filteredCriminals = query.isEmpty
          ? []
          : filteredCriminals
              .where((criminal) =>
                  criminal.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Criminals')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCriminals,
              decoration: const InputDecoration(
                labelText: 'Search by name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('criminals').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                List<String> criminals = snapshot.data!.docs
                    .map((doc) => doc['fullName'].toString())
                    .toList();

                return ListView.builder(
                  itemCount: filteredCriminals.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(criminals[index]), // Use the 'criminals' list here
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
