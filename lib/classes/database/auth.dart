import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  Auth.internal();
  static final Auth instance = Auth.internal();
  factory Auth() => instance;

  FirebaseAuth get auth => FirebaseAuth.instance;
  User get user => auth.currentUser!;
  String get userUID => user.uid;

  bool get logged {
    if (user.isAnonymous) return false;
    if (user.email == null) return false;
    return true;
  }

  Future<void> continueWith(String email, String password) async {

    try {
      try {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (e) {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }
}
