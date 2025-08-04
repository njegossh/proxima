import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/review.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:proxima/classes/models/review.dart';
import 'package:proxima/classes/models/user.dart';

class ReviewMainController extends ChangeNotifier {
  List<Review> reviewsList = [];
  Map<String, User> reviewsMap = {};

  Future<void> init() async {
    await fetchReviews();
    await fetchAllUsers();
  }

  Future<List<Review>> fetchReviews() async {
    await Future.delayed(const Duration(seconds: 2));
    reviewsList = reviews;
    notifyListeners();
    return reviewsList;
  }

  Future<User?> getUserById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
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
}