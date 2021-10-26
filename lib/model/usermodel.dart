import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModelInfo {
  Map<String, dynamic> userModelInfo;
  UserModelInfo(this.userModelInfo);

  factory UserModelInfo.latest(Map<String, dynamic> data) {
    return UserModelInfo(data);
  }
}

class UserModel with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // List<UserModelInfo> userList = [UserModelInfo({})];
  List<UserModelInfo> userList = [];

  List<UserModelInfo> get getLatestUserList => userList;

  Future<String> addUser(String? uid, String? email) async {
    try {
      var data = {
        "createAt": FieldValue.serverTimestamp(),
        "uid": uid,
        "email": email,
        "firstName": "",
        "lastName": "",
        "nickname": "",
        "photoUrl": "",
      };

      DocumentReference user = _firestore.collection("users").doc(uid);
      await user.set(data);
      return "addUser Success";
    } on FirebaseException catch (e) {
      return "addUser Error : ${e.message}";
    } catch (e) {
      return "addUser Error";
    }
  }

  Future<String> getUsers() async {
    try {
      CollectionReference users = _firestore.collection('users');
      QuerySnapshot querySnapshot = await users.get();
      List<QueryDocumentSnapshot> queryDocumentSnapshotList =
          querySnapshot.docs;

      final tmpUserList =
          queryDocumentSnapshotList.map((DocumentSnapshot snapshot) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return data;
      });

      List<UserModelInfo> _userList = tmpUserList.map((element) {
        return UserModelInfo.latest(element);
      }).toList();

      userList = _userList;

      // notifyListeners();
      return "getUsers Success.";
    } on FirebaseException catch (e) {
      return "getUsers Error : ${e.message}";
    } catch (e) {
      return "getUsers Error ${e.toString()}";
    }
  }
}
