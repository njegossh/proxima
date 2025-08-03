import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:proxima/config/firebase_options.dart';
import 'package:proxima/classes/models/user.dart' as userDTO;

import '../../main.dart';

class Database with ChangeNotifier {

  Database.internal();
  static final Database instance = Database.internal();
  factory Database() => instance;

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseAuth get auth => FirebaseAuth.instance;
  User get user => auth.currentUser!;
  String get userUID => user.uid;

  bool get logged {
    if (user.isAnonymous) return false;
    if (user.email == null) return false;
    return true;
  }

  Future<void> init() async {
    await Firebase.initializeApp( 
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /*
    final userDoc = userReference(userUID);
    final userSnapshot = await userDoc.get();
    final userJSON = userSnapshot.data() as Map;
    currentUser = userDTO.User.fromJson(userJSON, userUID);
    */
    currentUser = goranEdman;
  }

  Future<void> signIn(String email, String password) async {
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
