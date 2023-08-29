// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new criminal record to Firestore
  Future<void> addCriminalRecord(String criminalName) async {
    try {
      await _firestore.collection('criminals').add({
        'name': criminalName,
        
        // Add more fields as needed
      });
    } catch (e) {
    }
  }

  // Get a list of criminal records from Firestore
  Future<List<String>> getCriminalRecords() async {
    try {
      final querySnapshot = await _firestore.collection('criminals').get();
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      //print('Error getting criminal records: $e');
      return [];
    }
  }

  // Search for criminal records by name
  Future<List<String>> searchCriminalByName(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection('criminals')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '${query}z')
          .get();
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    } catch (e) {
      //print('Error searching criminal records: $e');
      return [];
    }
  }
}
