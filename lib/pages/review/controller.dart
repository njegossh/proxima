import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/database/reviews.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/classes/models/review.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';

class ReviewMainController extends ChangeNotifier {
  final Course course;

  User get user => currentUser;

  ReviewMainController({required this.course});

  List<Review> reviewsList = [];
  Map<String, User> reviewsMap = {};
  bool isLoading = false;

  Future<void> init() async {
    await fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading = true;
    notifyListeners();
    await fetchReviews();
    await fetchAllUsers();
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchReviews() async {
    reviewsList = await Database().fetchReviewsForCourseID(course.id!);
  }

  Future<User?> getUserById(String id) async {
    return Database().fetchUserFromID(id);
  }

  Future<void> fetchAllUsers() async {
    for (Review review in reviewsList) {
      final user = await getUserById(review.userID);
      if (user != null) {
        reviewsMap[review.userID] = user;
      }
    }
    notifyListeners();
  }

  String? validateForm(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter a comment.".tr;
    }
    return null;
  }

  Future<void> reviewWrite(Review review) async {
    await Database().createReview(review);
    await fetchAllData();
  }
}
