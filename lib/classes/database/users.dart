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
}
