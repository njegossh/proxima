import 'package:flutter/material.dart';
import 'package:proxima/pages/course_creation/main_page.dart';
import 'package:proxima/pages/init_account/main_page.dart';
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
              label: Text('Novi kurs'),
              icon: Icon(Icons.class_rounded),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CourseCreationMainPage();
                }));
              },
            );
          case HomePage.chats: 
            return Container();
          case HomePage.calendar: 
            return Container();
          case HomePage.account: 
            return FloatingActionButton.extended(
              label: Text('Izmeni'),
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return InitAccountMainPage();
                }));
              },
            );
        }
      }
    );
  }
}
