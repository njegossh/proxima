import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';

class FollowController extends ChangeNotifier {
  final String userId;
  final bool getFollowers;
  List<User> users = [];

  FollowController({required this.userId, required this.getFollowers});

  void updateUsers() async {
    if (getFollowers) {
      users = await Database().fetchFollowers(userId);
    }
    else {
      users = await Database().fetchFollowing(userId);
    }
    await Database().updateUser(currentUser);
    notifyListeners();
  }

  int get userCount => users.length;
}
