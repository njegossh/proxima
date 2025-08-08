import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/review.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:proxima/classes/models/review.dart';
import 'package:proxima/classes/models/user.dart';

class ReviewMainController extends ChangeNotifier {
  final String userId;
  final String classId;

  ReviewMainController({required this.userId, required this.classId});

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

  Future<List<Review>> fetchReviews() async {
    await Future.delayed(const Duration(milliseconds: 500));
    reviewsList = reviews.where((e) => e.classID == classId).toList();
    reviewsList.sort((a, b) => a.userID == userId ? -1 : 1);
    return reviewsList;
  }

  Future<User?> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return users.firstWhere((user) => user.id == id);
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
      return 'Please enter a comment';
    }
    return null;
  }

  Future<void> reviewWrite(Review review) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = reviews.indexWhere((e) => e.userID == review.userID);
    if (index == -1) {
      reviews.add(review);
    } else {
      reviews[index] = review;
    }
    await fetchAllData();
  }
}
