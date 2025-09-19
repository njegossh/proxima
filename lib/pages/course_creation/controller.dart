import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';

class CourseCreationController extends ChangeNotifier {
  Course? newCourse;
  final Course? existingCourse;

  final name = TextEditingController();
  final pricePerHour = TextEditingController();
  final description = TextEditingController();
  final videoURL = TextEditingController();

  String? thumbnailString;
  List<String> tagsList = [];

  CourseCreationController({this.existingCourse}) {
    if (existingCourse != null) {
      name.text = existingCourse!.name;
      pricePerHour.text = existingCourse!.pricePerHour.toString();
      description.text = existingCourse!.description ?? '';
      videoURL.text = existingCourse!.videoURL ?? '';
      thumbnailString = existingCourse!.thumbnailString;
      tagsList = List.from(existingCourse!.tags);
    }
  }

  void addTag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isNotEmpty && !tagsList.contains(trimmed)) {
      tagsList.add(trimmed);
      notifyListeners();
    }
  }

  void removeTag(String tag) {
    tagsList.remove(tag);
    notifyListeners();
  }

  Future<void> pickThumbnail() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await File(image.path).readAsBytes();
      thumbnailString = base64Encode(bytes);
      notifyListeners();
    }
  }

  Future<void> saveCourse(BuildContext context) async {
    if (existingCourse == null) { //Create
      newCourse = Course(
        name: name.text,
        userID: currentUser.id,
        tags: List.from(tagsList),
        pricePerHour: double.tryParse(pricePerHour.text) ?? 0,
        averageReview: 0,
        description: description.text,
        videoURL: videoURL.text,
        thumbnailString: thumbnailString,
        locationX: currentUser.locationX,
        locationY: currentUser.locationY,
      );
      await Database().createCourse(newCourse!);
    } else { //Edit
      existingCourse!
        ..name = name.text
        ..pricePerHour = double.tryParse(pricePerHour.text) ?? 0
        ..description = description.text
        ..videoURL = videoURL.text
        ..thumbnailString = thumbnailString
        ..tags = List.from(tagsList);

      await Database().updateCourse(existingCourse!);
    }

    await currentUser.reload();
    notifyListeners();
  }

  @override
  void dispose() {
    name.dispose();
    pricePerHour.dispose();
    description.dispose();
    videoURL.dispose();
    super.dispose();
  }
}
