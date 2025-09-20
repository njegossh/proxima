import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/calendar/main_page.dart';
import 'package:proxima/pages/chat/main_page.dart';
import 'package:proxima/pages/user/components/course_carousel.dart';
import 'package:proxima/pages/user/components/location.dart';
import 'package:proxima/pages/user/controller.dart';
import 'package:proxima/pages/video_call/main_page.dart';
import 'components/avatar.dart';
import 'components/interest_chips.dart';

class UserMainPage extends StatefulWidget {
  final User user;
  const UserMainPage({super.key, required this.user});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  late UserController controller;
  @override
  void initState() {
    controller = UserController(widget.user);
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(elevation: 0, title: Text(controller.user.fullName)),
          body: ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 150,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(width: 500, height: 275, child: Card()),
                    ),
                  ),

                  Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AvatarWidget(imageString: widget.user.imageString),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.user.fullName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatMainPage(otherUser: controller.user);
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.message, size: 25),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CalendarMainPage(user: controller.user);
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.calendar_month, size: 25),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return VideoCallMainPage(otherUser: widget.user);
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.video_camera_front_rounded, size: 25),
                  ),
                ],
              ),
              SizedBox(height: 16),
              LocationInfo(user: widget.user),
              SizedBox(height: 48),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.interests_outlined,
                      size: 25,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(width: 8),
                    Text("Interests:".tr, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: InterestChips(listOfInterests: widget.user.interests),
              ),
              SizedBox(height: 16),
              ...(widget.user.description != null &&
                      widget.user.description!.isNotEmpty)
                  ? [
                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: 25,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            SizedBox(width: 8),
                            Text("About:".tr, style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                widget.user.description!,
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  : [],
              SizedBox(height: 16),

              if (widget.user.courses != null &&
                  widget.user.courses!.isNotEmpty) ...[
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 25,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      SizedBox(width: 8),
                      Text("Courses:".tr, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                CourseCarousel(courses: widget.user.courses ?? []),
              ],
            ],
          ),
        );
      },
    );
  }
}
