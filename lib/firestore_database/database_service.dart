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
    required String imageUrl,
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
      'imageUrl': imageUrl,
    });
  }

  Future<void> updateCriminalDetails(
    String criminalDocId,
    String newName,
    String newFathersName,
    String newMothersName,
    String newAge,
    String newAddress,
    String newPhone,
    String newCriminalRecord,
    String newRelatedRecords,
    String newSummary,
    String newImageUrl,
  ) async {
    await _criminalsRef.doc(criminalDocId).update({
      'fullName': newName,
      'fathersName': newFathersName,
      'mothersname': newMothersName,
      'age': newAge,
      'address': newAddress,
      'phone': newPhone,
      'criminalRecord': newCriminalRecord,
      'relatedRecords': newRelatedRecords,
      'summary': newSummary,
      'imageUrl': newImageUrl,
    });
  }


  Future<void> deleteCriminal(String criminalDocId) async {
    await _criminalsRef.doc(criminalDocId).delete();
  }

  Stream<List<String>> getCriminals() {
    return _criminalsRef.snapshots().map(
      (querySnapshot) {
        List<String> criminalNames = [];

        for (var doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>?;
          if (data != null && data.containsKey('fullName') && data['fullName'] != null) {
            criminalNames.add(data['fullName'].toString());
          } else {
            criminalNames.add(''); // Return an empty string or a default value
          }
        }
        return criminalNames;
      },
    );
  }

  Future<Map<String, dynamic>> getCriminalDetails(String criminalName) async {
    QuerySnapshot querySnapshot = await _criminalsRef.where('fullName', isEqualTo: criminalName).get();
    if (querySnapshot.docs.isNotEmpty) {
      var data = querySnapshot.docs[0].data() as Map<String, dynamic>?;
      return data ?? {};
    }
    return {};
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

  Future<void> updateCriminalImage(String criminalDocId, String imageUrl) async {
    await _criminalsRef.doc(criminalDocId).update({
      'image': imageUrl,
    });
  }
}


