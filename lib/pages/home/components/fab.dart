import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/course_creation/main_page.dart';
import 'package:proxima/pages/init_account/main_page.dart';
import 'package:proxima/pages/search/main_page.dart';
import '../controller.dart';

class HomeFAB extends StatelessWidget {
  final HomeController controller;
  const HomeFAB({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        switch(controller.page) {
          case HomePage.courses: 
            return FloatingActionButton.extended(
              label: Text('Search'.tr),
              icon: Icon(Icons.search),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchMainPage();
                  }));
              },
            );
          case HomePage.chats: 
            return Container();
          case HomePage.calendar: 
            return Container();
          case HomePage.account: 
            return FloatingActionButton.extended(
              label: Text('Edit'.tr),
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return InitAccountMainPage(isInitialized: true,);
                }));
              },
            );
        }
      }
    );
  }
}
