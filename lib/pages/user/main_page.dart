import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/course.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:proxima/pages/user/components/course_carousel.dart';
import 'components/avatar.dart';
import 'components/interest_chips.dart';

class UserMainPage extends StatelessWidget {
  UserMainPage({super.key});

  final user = nikolaNikolic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: ListView(
        children: [
          SizedBox(height: 24,),
          Center(child: AvatarWidget(avatarURL: user.avatarURL)),
          SizedBox(height: 24,),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Text(
                user.fullName,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          SizedBox(height: 12,),
          Align(
            alignment: Alignment.center,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_pin_circle_outlined),
                    Text(
                      user.locationDesc != null
                          ? user.locationDesc!.join(", ")
                          : "Nema podataka za lokaciju.",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(child: InterestChips(listOfInterests: user.interests)),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    bottom: 12,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    user.description ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
          CourseCarousel(courses: courses,)
        ],
      ),
    );
  }
}
