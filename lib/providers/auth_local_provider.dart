import 'package:firebase_auth/firebase_auth.dart';

class AuthLocalProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleAuthProvider googleProvider = GoogleAuthProvider();

  Future<UserCredential> signInWithGoogle() async {
    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  // Auth State
  //Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  //User? get currentUser => _firebaseAuth.currentUser;

  User? getCurrentUser() => _firebaseAuth.currentUser;

  // String? getUid() => _firebaseAuth.currentUser?.uid;

  Future<UserCredential> loginUser(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> registerUser(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // Future<void> resetPassword(String email) async {
  //   await _firebaseAuth.sendPasswordResetEmail(email: email);
  // }

  // Deletes and signs out the user
  // Future<void> deleteUserAccount() async =>
  //     await _firebaseAuth.currentUser!.delete();

  Future<void> logOut() async => await _firebaseAuth.signOut();
}
