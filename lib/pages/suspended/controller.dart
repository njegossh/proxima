import 'package:flutter/material.dart';
import 'package:proxima/classes/database/auth.dart';
import 'package:proxima/pages/home/controller.dart';

class SuspendedController extends ChangeNotifier {
  int pageIndex = 0;

  HomePage get page => HomePage.values[pageIndex];

  void setPageIndex(int i) {
    pageIndex = i;
    notifyListeners();
  }

  Future<void> logout() async {
    await Auth().logout();
  }
}
