import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addUser(String? uid, String? email) async {
    try {
      var data = {
        "createAt": FieldValue.serverTimestamp(),
        "uid": uid,
        "email": email,
        "firstName": "",
        "lastName": "",
        "nickname": "",
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
}
