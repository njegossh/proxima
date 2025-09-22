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

  Future<void> updateUserFollowedList(String userID, List<String> followedUserIDs) async {
    await users.doc(userID).update({
      'followedUserIDs': followedUserIDs,
    });
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

  Stream<User> userStream(String userID) {
    return users.doc(userID).snapshots().map((snap) {
      return User.fromJson(snap.data() as Map, snap.id);
    });
  }

  /// Vraca listu korisnika koje user prati (following)
  Future<List<User>> fetchFollowing(String userID) async {
    final snap = await users.doc(userID).get();
    final data = snap.data() as Map<String, dynamic>?;

    if (data == null || data['followedUserIDs'] == null) return [];

    final followedIDs = List<String>.from(data['followedUserIDs']);
    if (followedIDs.isEmpty) return [];

    final query = await users
        .where(FieldPath.documentId, whereIn: followedIDs)
        .get();
    return query.docs.map((doc) {
      return User.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  /// Vraca listu korisnika koji prate odredjenog usera (followers)
  Future<List<User>> fetchFollowers(String userID) async {
    final query = await users
        .where('followedUserIDs', arrayContains: userID)
        .get();

    return query.docs.map((doc) {
      return User.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
