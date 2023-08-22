// database_service.dart
// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _criminalsRef = FirebaseFirestore.instance.collection('criminals');

  Future<void> addCriminal({
    required String fullName,
    required String fathersname,
    required String mothersName,
    required String age,
    required String address,
    required String phone,
    required String criminalRecord,
    required String relatedRecords,
    required String summary,
  }) async {
    await _criminalsRef.add({
      'fullName': fullName,
      'fathersname': fathersname,
      'mothersname': mothersName,
      'age': age,
      'address': address,
      'phone': phone,
      'criminalRecord': criminalRecord,
      'relatedRecords': relatedRecords,
      'summary': summary,
    });
  }

  Future<void> updateCriminal(String criminalDocId, String newName) async {
    await _criminalsRef.doc(criminalDocId).update({'name': newName});
  }

  Future<void> deleteCriminal(String criminalDocId) async {
    await _criminalsRef.doc(criminalDocId).delete();
  }

  Stream<List<String>> getCriminals() {
    return _criminalsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['name'].toString()).toList();
    });
  }
  Future<void> updateCriminalField(
  String criminalDocId,
  String fieldName,
  String newValue,
) async {
  await _criminalsRef.doc(criminalDocId).update({
    fieldName: newValue,
  });
}

}
