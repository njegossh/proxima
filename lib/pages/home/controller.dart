import 'package:flutter/material.dart';

enum HomePage { courses, chats, calendar, account }

class HomeController extends ChangeNotifier {
  int pageIndex = 0;

  HomePage get page => HomePage.values[pageIndex];

  void setPageIndex(int i){
    pageIndex = i;
    notifyListeners();
  }
}
