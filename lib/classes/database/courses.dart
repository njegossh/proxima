import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/classes/models/course_tag.dart';
import 'package:proxima/main.dart';
import 'database.dart';

extension CoursesDB on Database {
  CollectionReference get courses => firestore.collection('courses');
  CollectionReference get courseTagGroups =>
      firestore.collection('course_tags');

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
    return result.docs.map((doc) {
      return Course.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }

  double kmToLatDelta(double km) {
    return km / 111.0; // 1° latitude ≈ 111 km
  }

  double kmToLngDelta(double km, double latitude) {
    return km / (111.0 * cos(latitude * pi / 180));
  }

  Future<List<Course>> fetchCoursesInterestedIn() async {
    Query query = courses.limit(20);

    if (currentUser.interests.isNotEmpty) {
      final lat = currentUser.locationY; // latitude
      final lng = currentUser.locationX; // longitude

      final latDelta = kmToLatDelta(currentUser.range);
      final lngDelta = kmToLngDelta(currentUser.range, lat);

      query = query
          .where('tags', arrayContainsAny: currentUser.interests)
          .where(
            'locationX',
            isLessThan: lng + lngDelta,
            isGreaterThan: lng - lngDelta,
          )
          .where(
            'locationY',
            isLessThan: lat + latDelta,
            isGreaterThan: lat - latDelta,
          );
    }

    final result = await query.get();
    return result.docs.map((doc) {
      return Course.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }

  Future<List<CourseTagGroup>> fetchAllCourseTagGroups() async {
    final result = await courseTagGroups.get();
    return result.docs.map((doc) {
      return CourseTagGroup.fromJson(doc.data() as Map);
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
    if (name != null && name.isNotEmpty) {
      query = query.where('name', isEqualTo: name);
    }
    if (minPrice != null || maxPrice != null) {
      query = query.where(
        'pricePerHour',
        isGreaterThanOrEqualTo: minPrice,
        isLessThanOrEqualTo: maxPrice,
      );
    }
    if (tags != null && tags.isNotEmpty) {
      query = query.where('tags', arrayContainsAny: tags);
    }
    if (sortBy == 'name') {
      query = query.orderBy('name');
    } else if (sortBy == 'price_low') {
      query = query.orderBy('pricePerHour');
    } else if (sortBy == 'price_high') {
      query = query.orderBy('pricePerHour', descending: true);
    }

    final result = await query.limit(20).get();
    return result.docs.map((doc) {
      return Course.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }
}
