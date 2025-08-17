import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';

class CourseCreationController extends ChangeNotifier {
  Course? newCourse;
  int get courselen => currentUser.courses?.length ?? 0;

  final name = TextEditingController();
  final tags = TextEditingController();
  final pricePerHour = TextEditingController();
  final description= TextEditingController();
  final videoURL= TextEditingController();
  final thumbnailURL= TextEditingController();

  Future<void> createCourse() async {
    newCourse = Course(
      name: name.text,
      userID: currentUser.id,
      tags: tags.text.split(','),
      pricePerHour: double.parse(pricePerHour.text),
      averageReview: 0,
      description: description.text,
      videoURL: videoURL.text,
      thumbnailURL: thumbnailURL.text,
      locationX: currentUser.locationX,
      locationY: currentUser.locationY,
    );

    await Database().createCourse(newCourse!);
    await currentUser.reload();

    notifyListeners();
  }
}
