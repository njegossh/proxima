import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'course.dart';

class Appointment extends ChangeNotifier {
  String? id;
  DateTime from, to;
  String courseID;
  bool confirmed;
  String studentID;

  Course? course;

  Appointment({
    this.id,
    this.course,
    required this.from,
    required this.to,
    required this.courseID,
    required this.confirmed,
    required this.studentID,
  });

  String get name {
    if(course == null) reload();
    return course?.name ?? '?';
  }

  static Appointment fromJson(Map json, String? id){
    return Appointment(
      id: id,
      from: DateTime.parse(json['from'] ?? ''), 
      to: DateTime.parse(json['to'] ?? ''), 
      courseID: json['courseID'],
      confirmed: json['confirmed'] ?? false,
      studentID: json['studentID'],
    );
  }

  Map<String, Object> toJson(){
    return {
      'from' : from.toIso8601String(),
      'to': to.toIso8601String(),
      'courseID': courseID,
      'confirmed': confirmed,
      'studentID': studentID,
    };
  }

  Future<Course> reloadCourse() async {
    course = await Database().fetchCourseFromID(courseID);
    notifyListeners();
    return course!;
  }

  Future reload() async {
    await reloadCourse();
  }
}
