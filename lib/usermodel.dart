import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addUser(String? uid, String? email) async {
    // CollectionReference users = _firestore.collection("users");
    DocumentReference user = _firestore.collection("users").doc(uid);

    var data = {
      "createAt": FieldValue.serverTimestamp(),
      "uid": uid,
      "email": email,
    };

    try {
      await user.set(data);
      return "User Add Success.";
    } catch (e) {
      return "Firestore User Add Error.";
    }
  }

  Future<String> getUsers() async {
    CollectionReference users = _firestore.collection("users");
    try {
      // await users.get();
      return "getUser Success.";
    } catch (e) {
      return "getUser Error.";
    }
  }
}
