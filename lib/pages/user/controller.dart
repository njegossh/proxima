import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';

class UserController extends ChangeNotifier {
  final User user;

  UserController(this.user){
    user.addListener(notifyListeners);
  }

  Future<void> init() async {
    await user.reload();
  }
}
