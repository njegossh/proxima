import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proxima/firebase_options.dart';

class Database with ChangeNotifier {

  Database.internal();
  static final Database instance = Database.internal();
  factory Database() => instance;

  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static User get user => auth.currentUser!;

  static bool get logged {
    if (user.isAnonymous) return false;
    if (user.email == null) return false;
    return true;
  }

  Future<void> init() async {
    await Firebase.initializeApp( 
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> signIn(String email, String password) async {
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
    }
  }

  DocumentReference userReference(String userID){
    return firestore.collection('users').doc(userID);
  }
  DocumentReference appointmentReference(String appID){
    return firestore.collection('appointments').doc(appID);
  }
  DocumentReference classReference(String classID){
    return firestore.collection('classes').doc(classID);
  }
}
