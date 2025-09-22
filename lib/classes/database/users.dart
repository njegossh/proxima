import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/user.dart';
import 'database.dart';

extension UsersDB on Database {
  CollectionReference get users => firestore.collection('users');

  Future<User> fetchUserFromID(String userID) async {
    final snap = await users.doc(userID).get();
    return User.fromJson(snap.data() as Map, userID);
  }

  Future<void> updateUser(User user) async {
    await users.doc(user.id).set(user.toJson());
  }

  Future<void> suspendUser(String userID) async {
    await users.doc(userID).update({'suspended': true});
  }

  Future<void> activateUser(String userID) async {
    await users.doc(userID).update({'suspended': false});
  }

  Future<List<User>> fetchSuspendedUsers() async {
    final snap = await users.where('suspended', isEqualTo: true).get();
    return snap.docs.map((doc) {
      return User.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }
}
