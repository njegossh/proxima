export 'appointments.dart';
export 'courses.dart';
export 'users.dart';
export 'chat.dart';
export 'map.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proxima/classes/database/users.dart';
import 'package:proxima/classes/models/user.dart';
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
  }

  Future<bool> tryFetchingCurrentUser() async {
    try {
      currentUser = await fetchUserFromID(Auth().userUID);
      currentUser.reload(notify: false);
      return true;
    } catch (e) {
      try {
        currentUser = User.blankWithID(Auth().userUID);
        debugPrint('$e');
        return false;
      } catch (e) {
        debugPrint('$e');
        return false;
      }
    }
  }

  Stream<List<User>> suspendedUsersStream() {
    return firestore
        .collection('users')
        .where('suspended', isEqualTo: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => User.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }
}
