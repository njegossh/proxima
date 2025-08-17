import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/database/reviews.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/classes/models/review.dart';
import 'package:proxima/main.dart';

class CourseMainController extends ChangeNotifier {
  final Course course;
  List<Review> reviewList = [];
  bool isLoading = false;

  CourseMainController({
    required this.course,
  }){
    course.addListener(notifyListeners);
  }

  Future<List<Review>> fetchReviews() async {
    isLoading = true;
    notifyListeners();

    reviewList = await Database().fetchReviewsForCourseID(course.id!);

    //TODO videti da li ovo ostaje ispod
    reviewList.shuffle();
    reviewList = reviewList.take(2).toList();

    isLoading = false;
    notifyListeners();

    return reviewList;
  }

  Future<void> init() async {
    await fetchReviews();
    await course.reload();
  }
}
