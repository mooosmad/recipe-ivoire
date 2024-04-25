import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredential.user;
      }
    } else {
      throw FirebaseAuthException(
        message: "Sign in aborded by user",
        code: "ERROR_ABORDER_BY_USER",
      );
    }
    return null;
  }

  // getProfileImage() {
  //   if (_firebaseAuth.currentUser.photoURL != null) {
  //     return Image.network(_firebaseAuth.currentUser.photoURL,
  //         height: 100, width: 100);
  //   } else {
  //     return Icon(Icons.account_circle, size: 23);
  //   }
  // }

  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String? email, String? password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signUp({String? email, String? password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
