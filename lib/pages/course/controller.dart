import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/review.dart';
import 'package:proxima/classes/models/review.dart';

class CourseMainController extends ChangeNotifier {
  List<Review> reviewList = [];
  bool isLoading = false;

  Future<List<Review>> fetchReviews() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    reviewList = List.from(reviews);
    reviewList.shuffle();
    reviewList = reviewList.take(2).toList();

    isLoading = false;
    notifyListeners();

    return reviewList;
  }

  Future<void> init() async {
    await fetchReviews();
  }
}