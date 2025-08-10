import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';
import 'database.dart';

extension CoursesDB on Database {

  CollectionReference get courses => firestore.collection('courses');

  Future<Course> fetchCourseFromID(String courseID) async {
    final snap = await courses.doc(courseID).get();
    return Course.fromJson(snap.data() as Map, courseID);
  }

  Future<void> createCourse(Course course) async {
    final snap = await courses.add(course.toJson());
    course.id = snap.id;
  }

  Future<void> updateCourse(Course course) async {
    await courses.doc(course.id).update(course.toJson());
  }

  Future<List<Course>> fetchCoursesForUserID(String userID) async {
    final query = courses.where('userID', isEqualTo: userID);
    final result = await query.get();
    return result.docs.map((doc){
      return Course.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }

  Future<List<Course>> fetchCoursesInterestedIn() async {
    Query query = courses;
    if(currentUser.interests.isNotEmpty){
      query = query.where(
        'tags', arrayContainsAny: currentUser.interests,
      );
    }
    final result = await query.get();
    return result.docs.map((doc){
      return Course.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }

  Future<List<Course>> fetchCoursesWithParams({
    String? name,
    double? minPrice,
    double? maxPrice,
    List<String>? tags,
    String? sortBy,
  }) async {
    Query query = courses;
    if(name != null && name.isNotEmpty){
     query = query.where('name', isEqualTo: name);
    }
    if(minPrice != null || maxPrice != null){
      query = query.where(
        'pricePerHour', 
        isGreaterThanOrEqualTo: minPrice,
        isLessThanOrEqualTo: maxPrice,
      );
    }
    if(tags != null && tags.isNotEmpty){
      query = query.where('tags', arrayContainsAny: tags);
    }
    if(sortBy == 'name') {
      query = query.orderBy('name');
    } else if (sortBy == 'price_low') {
      query = query.orderBy('pricePerHour');
    } else if (sortBy == 'price_high') {
      query = query.orderBy('pricePerHour', descending: true);
    }
    final result = await query.limit(20).get();
    return result.docs.map((doc){
      return Course.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }
}
