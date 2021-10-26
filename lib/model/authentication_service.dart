import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  AuthenticationService(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Sign In Success.";
    } on FirebaseAuthException catch (e) {
      return "Sign In FirebaseAuthException : ${e.message}";
    } catch (e) {
      return "Sign In Error : ${e.toString()}";
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Sign Up Success.";
    } on FirebaseAuthException catch (e) {
      return "Sign Up FirebaseAuthException : ${e.message}";
    } catch (e) {
      return "Sign Up Error : ${e.toString()}";
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Sign Out Success.";
    } on FirebaseAuthException catch (e) {
      return "Sign Out FirebaseAuthException : ${e.message}";
    } catch (e) {
      return "Sign Out Error : ${e.toString()}";
    }
  }
}
