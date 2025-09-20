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
    Query query = courses;

    final lat = userLatitude;
    final lng = userLongitude;

    print("user latitude $lat, and longitude: $lng, radiusinkm: $radiusInKilometers");

    final latDelta = kmToLatDelta(radiusInKilometers);
    final lngDelta = kmToLngDelta(radiusInKilometers, lat);

    print("user latitude delta $latDelta, and longitude delta: $lngDelta");

    final lessThanLng = lng + lngDelta;
    final greaterThanLng = lng - lngDelta;
    final lessThanLat = lat + latDelta;
    final greaterThanLat = lat - latDelta;

    print("lessThan long $lessThanLng greaterThanLong $greaterThanLng | "
        "lessThanLAT $lessThanLat greaterThanLAT $greaterThanLat");

    query = query
        .where('locationY', isLessThanOrEqualTo: lessThanLng)
        .where('locationY', isGreaterThanOrEqualTo: greaterThanLng)
        .where('locationX', isLessThanOrEqualTo: lessThanLat)
        .where('locationX', isGreaterThanOrEqualTo: greaterThanLat);

    final result = await query.get();

    print("SLEDE REZULTATI");
    return result.docs.map((doc) {
      return Course.fromJson(doc.data() as Map, doc.id);
    }).toList();
  }
}
