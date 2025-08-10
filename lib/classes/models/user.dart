import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
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
  List<String> interests;

  List<Appointment>? appointments;
  List<Course>? courses;

  User({
    required this.id,
    required this.locationX,
    required this.locationY,
    this.locationDesc,
    required this.name,
    required this.surname,
    required this.range,
    this.avatarURL,
    this.description,
    required this.interests,
  }){
    addListener((){
      for( final app in appointments! ){
        app.addListener(notifyListeners);
      }
    });
  }

  static User fromJson(Map json, String id) {
    return User(
      id: id,
      locationX: json['locationX'], 
      locationY: json['locationY'], 
      name: json['name'], 
      range: json['range'],
      surname: json['surname'],
      locationDesc: (json['locationDesc'] as List? ?? []).map((i) => '$i').toList(),
      avatarURL: json['avatarURL'],
      description: json['description'],
      interests: (json['interests'] as List? ?? []).map((i) => '$i').toList(),
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
    );
  }

  String get fullName => '$name $surname';

  Future reloadAppointments() async {
    appointments = await Database().fetchAppointmentsForUserID(id);
    notifyListeners();
  }

  Future reloadCourses() async {
    courses = await Database().fetchCoursesForUserID(id);
    notifyListeners();
  }

  Future<void> reload() async {
    await reloadAppointments();
    await reloadCourses();
  }

  String get formmatedLocationDesc {
    if(locationDesc == null){
      return 'Nema podataka za lokaciju';
    } else {
      return locationDesc!.join(', ');
    }
  }
}
