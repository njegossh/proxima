import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'database.dart';

enum AuthStatus { unauthenticated, pendingProfile, active }

class Auth {
  Auth.internal();
  static final Auth instance = Auth.internal();
  factory Auth() => instance;


  Future<AuthStatus> get status async {
    if(!logged) return AuthStatus.unauthenticated;

    final exists = await Database().tryFetchingCurrentUser();
    if(exists) return AuthStatus.active;
    return AuthStatus.pendingProfile;
  }

  FirebaseAuth get auth => FirebaseAuth.instance;
  User? get user => auth.currentUser;
  String get userUID => user!.uid;

  bool get logged {
    if (user == null) return false;
    if (user!.isAnonymous) return false;
    if (user!.email == null) return false;
    return true;
  }

  Future<void> logout() async {
    await auth.signOut();
    await navigateToRootAndAuth();
  }

  Future<void> continueWith(String email, String password) async {
    //TODO email verify
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
