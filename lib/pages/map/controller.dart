import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';

class MainMapController extends ChangeNotifier {
  final MapController mapController = MapController();
  double radius = 1500;
  bool instructorsSheetVisible = false;

  List<User> instructors = [];
  List<Course> courses = [];

  LatLng userLocation = LatLng(0, 0);

  Future<void> init() async {
    getCurrentLocation();
    courses = await getCoursesWithingRadius();
  }

  Future<List<Course>> getCoursesWithingRadius() async {
      print("Radius: " + "${radius}");
      print("Radius/1000: " + "${radius/1000}");
    return await Database().getCoursesWithinRadius(
      userLocation.latitude,
      userLocation.longitude,
      radius / 1000, //radius je ovde u metrima a f-ja prima km
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

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled. Please enable.".tr);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied. Please enable.".tr);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission permanently denied. Please enable.".tr);
    }

    return await Geolocator.getCurrentPosition();
  }
}
