// firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference criminalsCollection =
      FirebaseFirestore.instance.collection('criminals');

  Future<void> addCriminal(String name, String details) async {
    await criminalsCollection.add({
      'name': name,
      'details': details,
    });
  }

  Future<void> updateCriminal(String criminalId, String newName) async {
    await criminalsCollection.doc(criminalId).update({'name': newName});
  }

  Future<void> deleteCriminal(String criminalId) async {
    await criminalsCollection.doc(criminalId).delete();
  }

  Stream<List<String>> getCriminals() {
    return criminalsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['name'].toString()).toList();
    });
  }
}
