import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/calendar/main_page.dart';
import 'package:proxima/pages/chat/main_page.dart';
import 'package:proxima/pages/user/components/course_carousel.dart';
import 'package:proxima/pages/user/components/location.dart';
import 'package:proxima/pages/user/controller.dart';
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
          appBar: AppBar(elevation: 0),
          body: ListView(
            children: [
              SizedBox(height: 24),
              Center(child: AvatarWidget(avatarURL: widget.user.avatarURL)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ElevatedButton(
                  onPressed: controller.unFollow, 
                  child: Text(widget.user.followingThisUser ? 'Following'.tr : 'Follow'.tr),
                ),
              ),
              SizedBox(height: 16),
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
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CalendarMainPage(user: controller.user);
                          },
                        ),
                      );
                    },
                    child: Icon(Icons.calendar_month, size: 25),
                  ),
                  OutlinedButton(
                    onPressed: null,
                    child: Icon(Icons.video_camera_front_rounded, size: 25),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(right: 16, left: 16),
                  child: Text(
                    widget.user.fullName,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              SizedBox(height: 16),
              LocationInfo(user: widget.user),
              Center(
                child: InterestChips(listOfInterests: widget.user.interests),
              ),
              (widget.user.description != null &&
                      widget.user.description!.isNotEmpty)
                  ? Align(
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
                    )
                  : SizedBox.shrink(),
              CourseCarousel(courses: widget.user.courses ?? []),
            ],
          ),
        );
      },
    );
  }
}
