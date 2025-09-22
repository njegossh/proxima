import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';

class FollowController extends ChangeNotifier {
  List<User> users;

  FollowController({required this.users});

  void updateUsers(List<User> newUsers) {
    users = newUsers;
    notifyListeners();
  }

  int get userCount => users.length;
}
