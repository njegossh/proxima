import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/classes/models/user.dart';

class MainMapController extends ChangeNotifier {
  final MapController mapController = MapController();
  double radius = 1500;
  bool instructorsSheetVisible = false;

  List<User> instructors = [];
  List<Course> courses = [];

  LatLng userLocation = LatLng(0, 0);

  Future<void> init() async {
    courses = await getCoursesWithingRadius();
  }

  Future<List<Course>> getCoursesWithingRadius() async {
    return await Database().getCoursesWithinRadius(
      userLocation.latitude,
      userLocation.longitude,
      radius,
    );
  }

  void setRadius(double val) {
    radius = val;
    notifyListeners();
  }

  void getCurrentLocation() async {
    Position position = await getCurrentPosition();
    final newLocation = LatLng(position.latitude, position.longitude);
    userLocation = newLocation;
    mapController.move(newLocation, 13);
    notifyListeners();
  }

  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
