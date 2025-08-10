
import 'package:flutter/material.dart';
import 'package:proxima/main.dart';

class HomeController extends ChangeNotifier {

  final pageController = PageController();

  int get page {
    try { return pageController.page!.toInt();
    } catch ( e ){ return 0; }
  }

  String get title {
    return {
      1: 'Chats',
      2: 'Calendar',
      3: currentUser.name,
    }[page] ?? 'Home';
  }

  HomeController(){
    pageController.addListener((){
      notifyListeners();
    });
  }

  Future<void> scrollTo(int newPage) {
    return pageController.animateToPage( 
      newPage, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeIn,
    );
  }
}
