import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';

class SuggestedCoursesController extends ChangeNotifier {
  List<Course>? suggestedCourses;

  Future<void> refresh() async {
    suggestedCourses = await Database().fetchCoursesInterestedIn();
    notifyListeners();
  }

  String getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      case DateTime.sunday:
        return "Sunday";
      default:
        return "";
    }
  }

  final tips = [
    "You can create your own courses!",
    "Chat with intructors or friends!",
    "You can book classes in course pages.",
    "You can search courses by filtering or sorting them!",
    "Easily edit profile or course!"
  ];

  String getRandomTip() {
    final random = Random();
    final index = random.nextInt(tips.length);
    return tips[index];
  }
}
