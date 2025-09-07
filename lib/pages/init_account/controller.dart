import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:proxima/main.dart';
import 'package:oktoast/oktoast.dart';

class InitAccountController extends ChangeNotifier {
  String? imageString;
  bool isInitialized;
  bool trackLocation = true;

  double _range = 10; // in km

  double get range => _range;

  set range(double value) {
    _range = value;
    notifyListeners();
  }

  final firstNameCtrl = TextEditingController(text: currentUser.name);
  final lastNameCtrl = TextEditingController(text: currentUser.surname);
  final avatarUrlCtrl = TextEditingController(text: currentUser.avatarURL);
  final locationDescCtrl = TextEditingController(
    text: currentUser.locationDesc?.join(', ') ?? '',
  );
  final interestsCtrl = TextEditingController(
    text: currentUser.interests.join(', '),
  );
  final descriptionCtrl = TextEditingController(text: currentUser.description);

  User get account => currentUser;

  InitAccountController({required this.isInitialized}) {
    avatarUrlCtrl.addListener(() {
      notifyListeners();
    });
    imageString = currentUser.imageString;
  }

  void trackLocationChange(bool? val) {
    trackLocation = val ?? false;
    //print("CHECK JE ${trackLocation}");
    notifyListeners();
  }

  Future<void> updateAccount() async {
    Position? position;

    if (trackLocation) {
      try {
        position = await _getUserLocation();
      } catch (e) {
        showToast(
          e.toString(),
          duration: const Duration(seconds: 2),
          position: ToastPosition.bottom,
          backgroundColor: Colors.black54,
          textStyle: const TextStyle(color: Colors.white, fontSize: 18),
        );
        return;
      }
    }

    double newLocX = trackLocation && position != null
        ? position.latitude
        : currentUser.locationX;

    //print("trackLoc ${trackLocation} | position.latitude ${position?.latitude} | currentUser.locationX ${currentUser.locationX} | newLocY ${newLocX}");

    double newLocY = trackLocation && position != null
        ? position.longitude
        : currentUser.locationY;

    //print("trackLoc ${trackLocation} | position.longitude ${position?.longitude} | currentUser.locationY ${currentUser.locationY} | newLocY ${newLocY}");

    await Database().updateUser(
      User(
        id: currentUser.id,
        name: firstNameCtrl.text,
        surname: lastNameCtrl.text,
        avatarURL: avatarUrlCtrl.text.isEmpty ? null : avatarUrlCtrl.text,
        imageString: imageString,
        description: descriptionCtrl.text,
        followedUserIDs: [],
        locationX: newLocX,
        locationY: newLocY,
        locationDesc: locationDescCtrl.text.isEmpty
            ? null
            : locationDescCtrl.text.split(',').map((e) => e.trim()).toList(),
        interests: interestsCtrl.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        range: _range,
      ),
    );

    if ((trackLocation && position != null) || !trackLocation) {
      navigateToRootAndAuth();
    }

    notifyListeners();
  }

  Future<Position> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.'.tr);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.'.tr);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.'.tr);
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    avatarUrlCtrl.dispose();
    descriptionCtrl.dispose();
    locationDescCtrl.dispose();
    interestsCtrl.dispose();
    super.dispose();
  }
}
