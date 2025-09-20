import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/course.dart';
import 'database.dart';
import 'dart:math';

extension MapDatabase on Database {
  double kmToLatDelta(double km) {
    return km / 111.0;
  }

  double kmToLngDelta(double km, double latitude) {
    return km / (111.0 * cos(latitude * pi / 180));
  }

  Future<List<Course>> getCoursesWithinRadius(
    double userLatitude,
    double userLongitude,
    double radiusInKilometers,
  ) async {
    Query query = courses.limit(20);

    final lat = userLatitude; // latitude
    final lng = userLongitude; // longitude

    final latDelta = kmToLatDelta(radiusInKilometers);
    final lngDelta = kmToLngDelta(radiusInKilometers, lat);

    query = query
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

    final result = await query.get();
    return result.docs.map((doc) {
      return Course.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }
}
