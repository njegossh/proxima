import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review.dart';
import 'database.dart';

extension ReviewsDB on Database {

  CollectionReference get reviews => firestore.collection('reviews');

  Future<void> createReview(Review review) async {
    final doc = await reviews.add(review.toJson());
    review.id = doc.id;
  }

  Future<List<Review>> fetchReviewsForCourseID(String courseID) async {
    final query = reviews.where('courseID', isEqualTo: courseID);
    final result = await query.get();
    return result.docs.map((doc){
      return Review.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }
}
