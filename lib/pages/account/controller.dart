import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/classes/mock/user.dart';

class AccountController extends ChangeNotifier {
  User? account;
  bool isLoading = false;

  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    account = nikolaNikolic;

    isLoading = false;
    notifyListeners();
  }

  void updateAccount({
    required String firstName,
    required String lastName,
    String? avatarURL,
    String? description,
    required String locX,
    required String locY,
    List<String>? locationDesc,
    required List<String> interests,
  }) {
    if (account == null) return;
    account = User(
      name: firstName,
      locationX: double.parse(locX),
      locationY: double.parse(locY),
      surname: lastName,
      avatarURL: avatarURL,
      description: description,
      locationDesc: locationDesc,
      interests: interests,
    );
    notifyListeners();
  }
}
