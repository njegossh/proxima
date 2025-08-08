import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:geolocator/geolocator.dart';

class AccountController extends ChangeNotifier {
  User? account;
  bool isLoading = false;
  bool trackLocation = false;

  late TextEditingController firstNameCtrl;
  late TextEditingController lastNameCtrl;
  late TextEditingController avatarUrlCtrl;
  late TextEditingController locXCtrl;
  late TextEditingController locYCtrl;
  late TextEditingController locationDescCtrl;
  late TextEditingController interestsCtrl;
  late TextEditingController descriptionCtrl;

  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    account = nikolaNikolic;

    firstNameCtrl = TextEditingController(text: account?.name ?? '');
    lastNameCtrl = TextEditingController(text: account?.surname ?? '');
    avatarUrlCtrl = TextEditingController(text: account?.avatarURL ?? '');
    locXCtrl = TextEditingController(text: account?.locationX.toString() ?? '');
    locYCtrl = TextEditingController(text: account?.locationY.toString() ?? '');
    descriptionCtrl = TextEditingController(text: account?.description ?? '');
    locationDescCtrl = TextEditingController(
      text: account?.locationDesc?.join(', ') ?? '',
    );
    interestsCtrl = TextEditingController(
      text: account?.interests.join(', ') ?? '',
    );

    isLoading = false;
    notifyListeners();
  }

  void trackLocationChange(bool? val) {
    trackLocation = val ?? false;
    notifyListeners();
  }

  Future<void> updateAccount() async {
    if (account == null) return;
    try {
      if (trackLocation) {
        Position pos = await _getUserLocation();
        account = User(
          name: firstNameCtrl.text,
          surname: lastNameCtrl.text,
          avatarURL: avatarUrlCtrl.text.isEmpty ? null : avatarUrlCtrl.text,
          description: descriptionCtrl.text,
          locationX: pos.latitude,
          locationY: pos.longitude,
          locationDesc: locationDescCtrl.text.isEmpty
              ? null
              : locationDescCtrl.text.split(',').map((e) => e.trim()).toList(),
          interests: interestsCtrl.text
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList(),
        );
      } else {
        account = User(
          name: firstNameCtrl.text,
          surname: lastNameCtrl.text,
          avatarURL: avatarUrlCtrl.text.isEmpty ? null : avatarUrlCtrl.text,
          description: descriptionCtrl.text,
          locationX: account!.locationX,
          locationY: account!.locationY,
          locationDesc: locationDescCtrl.text.isEmpty
              ? null
              : locationDescCtrl.text.split(',').map((e) => e.trim()).toList(),
          interests: interestsCtrl.text
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList(),
        );
      }
      notifyListeners();
    } catch (e) {}
  }

  Future<Position> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    avatarUrlCtrl.dispose();
    locXCtrl.dispose();
    locYCtrl.dispose();
    descriptionCtrl.dispose();
    locationDescCtrl.dispose();
    interestsCtrl.dispose();
    super.dispose();
  }
}
