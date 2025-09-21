import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart';
import 'package:proxima/classes/database/auth.dart';
import 'package:proxima/main.dart';

class WelcomeController extends ChangeNotifier{
  final pageController = PageController();
  final email = TextEditingController();
  final password = TextEditingController();
  String? emailError, passwordError;

  int get page {
    try {
      return pageController.page!.toInt();
    } catch ( e ){
      debugPrint('$e');
      return 0;
    }
  }

  String get actionName {
    if(page == 1) return "Confirm".tr;
    return "Continue".tr;
  }

  WelcomeController(){
    pageController.addListener((){
      notifyListeners();
    });
  }

  Future<String?> actionClick() async {
    if( page == 0 ){
      await goToPage(1);
    } else if ( page == 1 ){
      return await confirm();
    }
    return null;
  }

  Future<String?> confirm() async {

    emailError = email.text.isEmpty ? "Required".tr : null;
    passwordError = password.text.isEmpty ? "Required".tr : null;
    notifyListeners();

    if(emailError != null) return "Email required".tr;
    if(passwordError != null) return "Password required".tr;

    try {
      await Auth().continueWith(
        email.text, 
        password.text,
      );
      navigateToRootAndAuth();
      return null;
    } on FirebaseAuthException catch ( error ){
      return error.message;
    }
  }

  Future<void> goToPage(int page) async {
    await pageController.animateToPage(
      page, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.ease,
    );
  }
}
