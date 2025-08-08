import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proxima/classes/mock/course.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:proxima/classes/models/course.dart';

class CourseCreationController extends ChangeNotifier {
  Course? newCourse;
  int courselen = courses.length;

  final name = TextEditingController();
  final tags = TextEditingController();
  final pricePerHour = TextEditingController();
  final description= TextEditingController();
  final videoURL= TextEditingController();
  final thumbnailURL= TextEditingController();

  void createCourse() {
    newCourse = Course(
      name: name.text,
      userID: users[1].id ?? "bezID", //Ovde treba da ide id trenutnog korisnika /* TO DO */
      tags: tags.text.split(','),
      pricePerHour: double.parse(pricePerHour.text),
      averageReview: 0,
      description: description.text,
      videoURL: videoURL.text,
      thumbnailURL: thumbnailURL.text,
    );

    if (newCourse != null) {
      courses.add(newCourse!);
    }
    courselen = courses.length;
    notifyListeners();
  }
}
