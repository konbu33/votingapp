import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  AuthenticationService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In.";
    } on FirebaseAuthException catch (e) {
      return "FirebaseAuthException : ${e.message}";
    } catch (e) {
      return "Signed In Error.";
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up.";
    } on FirebaseAuthException catch (e) {
      return "FirebaseAuthException : ${e.message}";
    } catch (e) {
      return "Signed Up Error.";
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed Out.";
    } on FirebaseAuthException catch (e) {
      return "Sign Out Error : ${e.message}";
    } catch (e) {
      return "Sign Out Error.";
    }
  }
}
