import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:proxima/classes/models/user.dart';

class AccountController extends ChangeNotifier {
  User? account = nikolaNikolic;
  bool isLoading = false;

  Future<User> fetchReviews() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    account = nikolaNikolic;

    isLoading = false;
    notifyListeners();

    return account!;
  }

  Future<void> init() async {
    await fetchReviews();
  }
}
