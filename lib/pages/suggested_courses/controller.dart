
import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';

class SuggestedCoursesController extends ChangeNotifier {

  List<Course>? suggestedCourses;

  Future<void> refresh() async {
    suggestedCourses = await Database().fetchCoursesInterestedIn();
    notifyListeners();
  }

}
