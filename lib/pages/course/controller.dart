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

  CourseMainController({required this.course}) {
    course.addListener(notifyListeners);
  }

  Future<List<Review>> fetchReviews() async {
    isLoading = true;
    notifyListeners();

    reviewList = await Database().fetchReviewsForCourseID(course.id!);

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

  Future<bool> deleteCourse(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm deletion"),
        content: const Text("Are you sure you want to delete this course?"),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return false;

    await Database().deleteCourse(course.id!);

    return true;
  }
}
