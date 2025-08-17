import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';

class UserController extends ChangeNotifier {
  final User user;

  UserController(this.user){
    user.addListener(notifyListeners);
  }

  Future<void> init() async {
    await user.reload();
  }


  Future<void> unFollow() async {
    if(user.followingThisUser){
      currentUser.followedUserIDs.remove(user.id);
    } else {
      currentUser.followedUserIDs.add(user.id);
    }
    await Database().updateUser(currentUser);
    await currentUser.reload();
    notifyListeners();
  }
}
