import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:proxima/config/firebase_options.dart';
import '../../main.dart';
import 'auth.dart';

class Database with ChangeNotifier {

  Database.internal();
  static final Database instance = Database.internal();
  factory Database() => instance;

  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  Auth get auth => Auth();


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
