import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/calendar/main_page.dart';
import 'package:proxima/pages/chat/main_page.dart';
import 'package:proxima/pages/user/components/course_carousel.dart';
import 'package:proxima/pages/user/components/location.dart';
import 'package:proxima/pages/user/components/report_page.dart';
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
          floatingActionButton: currentUser.superuser
              ? FloatingActionButton.extended(
                  onPressed: () async {
                    await controller.toggleSuspension();
                  },
                  backgroundColor: widget.user.suspended
                      ? Theme.of(context)
                            .colorScheme
                            .primary
                      : Theme.of(context).colorScheme.error,
                  icon: Icon(
                    widget.user.suspended
                        ? Icons.app_registration_rounded
                        : Icons.app_blocking_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    widget.user.suspended ? "Activate".tr : "Suspend".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : null,
          body: ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 250,
                    margin: EdgeInsets.only(left: 8, right: 8),
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
                      child: SizedBox(width: 400, height: 310, child: Card()),
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
              Center(
                child: widget.user.followingThisUser
                    ? SizedBox(
                        height: 30,
                        child: OutlinedButton(
                          onPressed: controller.unFollow,

                          child: Text(
                            "Following".tr,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 30,
                        child: FilledButton(
                          onPressed: controller.unFollow,
                          child: Text(
                            "Follow".tr,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  SizedBox(
                    height: 35,
                    child: OutlinedButton(
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
                      child: Icon(Icons.message, size: 20),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: OutlinedButton(
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
                      child: Icon(Icons.calendar_month, size: 20),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: OutlinedButton(
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
                      child: Icon(Icons.video_camera_front_rounded, size: 20),
                    ),
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
                    Text("Interests".tr, style: TextStyle(fontSize: 18)),
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
                            Text("About".tr, style: TextStyle(fontSize: 18)),
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
              SizedBox(height: 32),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_down_circle,
                      size: 25,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(width: 8),
                    Text("Options".tr, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ReportPage(userController: controller),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.report),
                      SizedBox(width: 8),
                      Text("Report".tr),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                      Text("Courses".tr, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                CourseCarousel(courses: widget.user.courses ?? []),
              ],
            ],
          ),
        );
      },
    );
  }
}
