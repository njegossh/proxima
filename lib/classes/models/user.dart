import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/main.dart';
import 'appointment.dart';
import 'course.dart';

class User extends ChangeNotifier {
  static late User current;

  String id;
  double locationX, locationY;
  double range;
  List<String>? locationDesc;
  String name, surname;
  String? description;
  String? avatarURL;
  String? locale;
  List<String> interests;
  List<String> followedUserIDs;

  List<Appointment>? appointments;
  List<Appointment>? attending;
  List<Course>? courses;
  List<User>? followedUsers;

  bool get followingThisUser {
    return currentUser.followedUserIDs.contains(id);
  }

  List<Appointment> get calendarAppointments {
    List<Appointment> result = [];
    result.addAll(appointments ?? []);
    result.addAll(attending ?? []);
    return result;
  }

  List<Appointment> get pendingAttending {
    return attending?.where((app) => !app.confirmed).toList() ?? [];
  }

  List<Appointment> get confirmedAttending {
    return attending?.where((app) => app.confirmed).toList() ?? [];
  }

  List<Appointment> get pendingAppointments {
    return appointments?.where((app) => !app.confirmed).toList() ?? [];
  }

  List<Appointment> get confirmedAppointments {
    return appointments?.where((app) => app.confirmed).toList() ?? [];
  }

  User({
    required this.id,
    required this.locationX,
    required this.locationY,
    this.locationDesc,
    required this.name,
    required this.surname,
    this.range = 100, //km
    this.avatarURL,
    this.description,
    required this.interests,
    this.locale,
    required this.followedUserIDs,
  }) {
    //TODO MARKO  ovde stavlja svim app u appointments! listener ali je null pri inicijalizaciji ja sam stavio proveru
    if (appointments != null) {
      addListener(() {
        for (final app in appointments!) {
          app.addListener(notifyListeners);
        }
      });
    }
  }

  static User fromJson(Map json, String id) {
    return User(
      id: id,
      locationX: json['locationX'],
      locationY: json['locationY'],
      name: json['name'],
      range: json['range'],
      surname: json['surname'],
      locationDesc: (json['locationDesc'] as List? ?? [])
          .map((i) => '$i')
          .toList(),
      avatarURL: json['avatarURL'],
      description: json['description'],
      interests: (json['interests'] as List? ?? []).map((i) => '$i').toList(),
      locale: json['locale'],
      followedUserIDs: (json['followedUserIDs'] as List? ?? [])
          .map((i) => '$i')
          .toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'locationX': locationX,
      'locationY': locationY,
      'name': name,
      'surname': surname,
      'locationDesc': locationDesc,
      'avatarURL': avatarURL,
      'description': description,
      'interests': interests,
      'range': range,
      'locale': locale,
      'followedUserIDs': followedUserIDs,
    };
  }

  static User blankWithID(String id) {
    return User(
      id: id,
      locationX: -1,
      locationY: -1,
      range: -1,
      name: '',
      surname: '',
      interests: [],
      followedUserIDs: [],
    );
  }

  String get fullName => '$name $surname';

  Future reloadAppointments({bool notify = true}) async {
    if (courses?.isEmpty ?? true) await reloadCourses();
    appointments = await Database().fetchAppointmentsForCourseIDs(
      courses!.map((course) => course.id!),
    );
    if (notify) notifyListeners();
  }

  Future reloadAttending({bool notify = true}) async {
    attending = await Database().fetchAttendingForUserID(currentUser.id);
    if (notify) notifyListeners();
  }

  Future reloadFollowedUsers({bool notify = true}) async {
    final result = <User>[];
    for (final userID in followedUserIDs) {
      result.add(await Database().fetchUserFromID(userID));
    }
    followedUsers = result;
    if (notify) notifyListeners();
  }

  Future reloadCourses({bool notify = true}) async {
    courses = await Database().fetchCoursesForUserID(id);
    if (notify) notifyListeners();
  }

  Future<void> reload({bool notify = true}) async {
    await reloadAttending(notify: notify);
    await reloadCourses(notify: notify);
    await reloadAppointments(notify: notify);
    await reloadFollowedUsers(notify: notify);
  }

  String get formmatedLocationDesc {
    if (locationDesc == null) {
      return 'Nema podataka za lokaciju';
    } else {
      return locationDesc!.join(', ');
    }
  }
}
