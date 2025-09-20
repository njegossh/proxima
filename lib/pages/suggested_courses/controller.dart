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
}
