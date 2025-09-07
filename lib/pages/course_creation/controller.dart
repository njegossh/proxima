import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';

class CourseCreationController extends ChangeNotifier {
  Course? newCourse;
  int get courselen => currentUser.courses?.length ?? 0;

  final name = TextEditingController();
  final tags = TextEditingController();
  final pricePerHour = TextEditingController();
  final description = TextEditingController();
  final videoURL = TextEditingController();

  String? thumbnailString;

  Future<void> pickThumbnail() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await File(image.path).readAsBytes();
      thumbnailString = base64Encode(bytes);
      notifyListeners();
    }
  }

  Future<void> createCourse() async {
    newCourse = Course(
      name: name.text,
      userID: currentUser.id,
      tags: tags.text.split(','),
      pricePerHour: double.tryParse(pricePerHour.text) ?? 0,
      averageReview: 0,
      description: description.text,
      videoURL: videoURL.text,
      thumbnailString: thumbnailString,
      locationX: currentUser.locationX,
      locationY: currentUser.locationY,
    );

    await Database().createCourse(newCourse!);
    await currentUser.reload();
    notifyListeners();
  }
}
