import 'package:flutter/material.dart';
import 'package:proxima/classes/util/translations.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/account/main_page.dart';
import 'package:proxima/pages/calendar/components/calendar_body.dart';
import 'package:proxima/pages/chat_list/main_page.dart';
import 'package:proxima/pages/home/controller.dart';
import 'package:proxima/pages/reports_view/main_page.dart';
import 'package:proxima/pages/settings/main_page.dart';
import 'package:proxima/pages/suggested_courses/main_page.dart';

import 'components/fab.dart';

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
            title: Text(
              {
                HomePage.courses: "Home".tr,
                HomePage.chats: "Chats".tr,
                HomePage.calendar: "Calendar".tr,
                HomePage.account: "Account".tr,
              }[controller.page]!,
            ),
            actions: [
              if (currentUser.superuser)
                Container(
                height: 30,
                margin: EdgeInsets.only(left: 16, right: 8),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ReportsView(),
                    ),
                  ),
                  child: Icon(Icons.report, size: 25),
                ),
              ),
              Container(
                height: 30,
                margin: EdgeInsets.only(left: 16, right: 8),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsMainPage(),
                    ),
                  ),
                  child: Icon(Icons.settings, size: 25),
                ),
              ),
              Container(
                height: 30,
                margin: EdgeInsets.only(left: 8, right: 16),
                child: InkWell(
                  onTap: () async {
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Confirm Logout".tr),
                          content: Text("Are you sure you want to log out?".tr),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                "Cancel".tr,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                "Logout".tr,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    if (shouldLogout ?? false) {
                      controller.logout();
                    }
                  },
                  child: Icon(Icons.logout_outlined, size: 25,),
                )
              ),
            ],
          ),
          floatingActionButton: HomeFAB(controller: controller),
          body: {
            HomePage.courses: SuggestedCoursesMainPage(),
            HomePage.chats: ChatList(),
            HomePage.calendar: CalendarBody(user: currentUser),
            HomePage.account: AccountMainPage(),
          }[controller.page]!,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                onTap: controller.setPageIndex,
                currentIndex: controller.pageIndex,
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
                selectedItemColor: Theme.of(context).colorScheme.secondary,
                unselectedItemColor: Theme.of(context).colorScheme.primary,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: "Chats".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month),
                    label: "Calendar".tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Account".tr,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
