import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NameModel {
  NameModel(this._firestore);

  final FirebaseFirestore _firestore;

  TextEditingController newNameController = TextEditingController();

  // String newName = "init";
  // set setNewName(String newName) => _newName = newName;
  // String get getNewName => _newName;

  Stream<QuerySnapshot> get getNames =>
      _firestore.collection('names').snapshots();

  Future<String> addName(String uid, String name) async {
    try {
      Map data = <String, dynamic>{
        "createAt": FieldValue.serverTimestamp(),
        "addUser": uid,
        "name": name,
        "nameYomi": "",
      };
      CollectionReference names = _firestore.collection('names');
      await names.add(data);
      return "addName Success";
    } on FirebaseException catch (e) {
      return "addName Error : ${e.message}";
    } catch (e) {
      return "addName Error : ${e.toString()}";
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
      return "delName Error : ${e.toString()}";
    }
  }

  Future<Map<String, dynamic>> getName(String docId) async {
    try {
      DocumentReference name = _firestore.collection('names').doc(docId);

      final data = await name.get();
      final resData = <String, dynamic>{
        "result": "getName Success.",
        "data": {
          "name": data.get("name"),
          "nameYomi": data.get("nameYomi"),
        }
      };
      return resData;
    } on FirebaseException catch (e) {
      return {"result": "getName Error : ${e.message}"};
    } catch (e) {
      return {"result": "getName Error : ${e.toString()}"};
    }
  }

  Future<String> updateName(
      String docId, String newName, String newNameYomi, String uid) async {
    try {
      DocumentReference name = _firestore.collection('names').doc(docId);

      Map<String, dynamic> data = {
        "updateAt": FieldValue.serverTimestamp(),
        "updateUser": uid,
        "name": newName,
        "nameYomi": newNameYomi,
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
