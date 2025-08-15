import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/account/components/edit_sheet.dart';
import 'package:proxima/pages/account/controller.dart';
import 'package:proxima/pages/account/main_page.dart';
import 'package:proxima/pages/calendar/components/calendar_body.dart';
import 'package:proxima/pages/chat_list/main_page.dart';
import 'package:proxima/pages/course_creation/main_page.dart';
import 'package:proxima/pages/home/controller.dart';
import 'package:proxima/pages/search/main_page.dart';
import 'package:proxima/pages/suggested_courses/main_page.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold( 
          appBar: AppBar(
            title: Text(controller.title),
            actions: [
              IconButton(
                icon: Icon(Icons.search_rounded),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchMainPage();
                  }));
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CourseCreationMainPage();
              }));
            },
          ),
          body: PageView( 
            controller: controller.pageController,
            children: [
              SuggestedCoursesMainPage(),
              ChatList(),
              CalendarBody(user: currentUser),
              AccountMainPage(controller: AccountController()),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller.scrollTo,
            currentIndex: controller.page,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'  
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chats'  
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_month),
                label: 'Calendar'  
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: currentUser.name,  
              ),
            ],
          ),
        );
      }
    );
  }
}
