import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proxima/main.dart';

class AccountController extends ChangeNotifier {
  bool trackLocation = false;

  final firstNameCtrl = TextEditingController(text: currentUser.name);
  final lastNameCtrl = TextEditingController(text: currentUser.surname);
  final locXCtrl = TextEditingController(
    text: currentUser.locationX.toString(),
  );
  final locYCtrl = TextEditingController(
    text: currentUser.locationY.toString(),
  );
  final locationDescCtrl = TextEditingController(
    text: currentUser.locationDesc?.join(', ') ?? '',
  );
  final interestsCtrl = TextEditingController(
    text: currentUser.interests.join(', '),
  );
  final descriptionCtrl = TextEditingController(text: currentUser.description);

  User get account => currentUser;

  AccountController();

  void trackLocationChange(bool? val) {
    trackLocation = val ?? false;
    notifyListeners();
  }

  Future<void> updateAccount() async {
    Position? position;
    if (trackLocation) position = await _getUserLocation();

    await Database().updateUser(
      User(
        id: currentUser.id,
        followedUserIDs: currentUser.followedUserIDs,
        name: firstNameCtrl.text,
        surname: lastNameCtrl.text,
        description: descriptionCtrl.text,
        locationX: position?.latitude ?? currentUser.locationX,
        locationY: position?.longitude ?? currentUser.locationY,
        locationDesc: locationDescCtrl.text.isEmpty
            ? null
            : locationDescCtrl.text.split(',').map((e) => e.trim()).toList(),
        interests: interestsCtrl.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        range: -1, //TODO
      ),
    );
    navigateToRootAndAuth();
  }

  Future<Position> _getUserLocation() async {
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
        return Future.error("Location permissions are denied. Please enable.".tr);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied. Please enable.".tr);
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    locXCtrl.dispose();
    locYCtrl.dispose();
    descriptionCtrl.dispose();
    locationDescCtrl.dispose();
    interestsCtrl.dispose();
    super.dispose();
  }

  Future<void> reloadAccount() async {
    currentUser = await Database().fetchUserFromID(currentUser.id);
    await currentUser.reloadCourses();
    notifyListeners();
  }
}
