import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User get user {
    if (_auth.currentUser == null) {
      return null;
    } else {
      return _auth.currentUser;
    }
  }

  get isAuth {
    return _auth.currentUser != null;
  }

  Future<void> signinWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    // ignore: unused_local_variable
    UserCredential authResult = await _auth.signInWithCredential(credential);
    notifyListeners();
  }

  Future<void> signout() async {
    await _googleSignIn.signOut();
    _auth.signOut();
    notifyListeners();
  }
}
