import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/database/report.dart';
import 'package:proxima/classes/models/report.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';

class UserController extends ChangeNotifier {
  final User user;

  List<User> following = [];
  List<User> followers = [];

  UserController(this.user) {
    user.addListener(notifyListeners);
  }

  Future<void> init() async {
    await user.reload();
    await loadFollowers();
    await loadFollowing();
  }

  /// Ucitava korisnike koje ovaj user prati
  Future<void> loadFollowing() async {
    following = await Database().fetchFollowing(user.id);
    notifyListeners();
  }

  /// Ucitava korisnike koji prate ovog usera
  Future<void> loadFollowers() async {
    followers = await Database().fetchFollowers(user.id);
    notifyListeners();
  }

  Future<void> unFollow() async {
    if (user.followingThisUser) {
      currentUser.followedUserIDs.remove(user.id);
    } else {
      currentUser.followedUserIDs.add(user.id);
    }
    await Database().updateUser(currentUser);
    await currentUser.reload();
    notifyListeners();
  }

  Future<void> sendReport(Report report) async {
    await Database().sendReport(report);
  }

  Future<void> toggleSuspension() async {
    if (user.suspended == true) {
      // Activate
      await Database().activateUser(user.id);
      user.suspended = false;
    } else {
      // Suspend
      await Database().suspendUser(user.id);
      user.suspended = true;
    }

    notifyListeners();
  }
}
