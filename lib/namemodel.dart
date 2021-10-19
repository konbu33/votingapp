import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class NameModel {
  NameModel(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<QuerySnapshot> get getNames =>
      _firestore.collection('names').snapshots();

  Future<String> addName(String uid, String name) async {
    try {
      Map data = <String, dynamic>{
        "createAt": FieldValue.serverTimestamp(),
        "addUser": uid,
        "name": name,
      };
      CollectionReference names = _firestore.collection('names');
      await names.add(data);
      return "addName Success";
    } on FirebaseException catch (e) {
      return "addName Error : ${e.message}";
    } catch (e) {
      return "addName Error : ${e}";
    }
  }

  Future<String> delName(String docId) async {
    try {
      DocumentReference name = _firestore.collection('names').doc(docId);

      await name.delete();
      return "delName Success.";
    } on FirebaseException catch (e) {
      return "delName Error : ${e.message}";
    } catch (e) {
      return "delName Error : ${e}";
    }
  }

  Future<String> getName(String docId) async {
    try {
      DocumentReference name = _firestore.collection('names').doc(docId);

      final data = await name.get();
      return data.get("name");
      return "editName Success.";
    } on FirebaseException catch (e) {
      return "editName Error : ${e.message}";
    } catch (e) {
      return "editName Error : ${e}";
    }
  }

  Future<String> updateName(String docId, String newName, String uid) async {
    try {
      DocumentReference name = _firestore.collection('names').doc(docId);

      Map<String, dynamic> data = {
        "updateAt": FieldValue.serverTimestamp(),
        "updateUser": uid,
        "name": newName,
      };

      await name.update(data);
      // await name.set(data);
      return "editName Success.";
    } on FirebaseException catch (e) {
      return "editName Error : ${e.message}";
    } catch (e) {
      return "editName Error : ${e}";
    }
  }
}
