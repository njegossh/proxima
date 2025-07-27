import 'package:flutter/material.dart';
import 'appointment.dart';

class User extends ChangeNotifier {
  String? id;
  double locationX, locationY;
  List<String>? locationDesc;
  String name, surname;
  String? description;
  String? showcaseUrl;
  String? avatarURL; //TODO
  List<String> interests;

  List<Appointment>? appointments;

  User({
    this.id,
    required this.locationX,
    required this.locationY,
    this.locationDesc,
    required this.name,
    required this.surname,
    this.avatarURL,
    this.description,
    this.showcaseUrl,
    required this.interests,
  }){
    addListener((){
      for( final app in appointments! ){
        app.addListener(notifyListeners);
      }
    });
  }

  static User fromJson(Map json, String id){
    return User(
      id: id,
      locationX: json['locationX'], 
      locationY: json['locationY'], 
      name: json['name'], 
      surname: json['surname'],
      locationDesc: json['locationDesc'],
      avatarURL: json['avatarURL'],
      description: json['description'],
      showcaseUrl: json['showcaseUrl'],
      interests: json['interests'],
    );
  }

  String get fullName => '$name $surname';

  Future<List<Appointment>> loadAppointments() async {
    if(appointments == null) await reloadAppointments();
    return appointments!;
  }

  Future<List<Appointment>> reloadAppointments() async {
    appointments = [
      Appointment(
        from: DateTime(2025, 6, 27), 
        to: DateTime(2025, 7, 26, 12), 
        classID: 'ccc',
      ),
      Appointment(
        from: DateTime(2025, 7, 27, 7), 
        to: DateTime(2025, 7, 27, 8), 
        classID: 'aaa',
      ),
      Appointment(
        from: DateTime(2025, 7, 27, 8), 
        to: DateTime(2025, 7, 27, 9), 
        classID: 'bbb',
      ),
      Appointment(
        from: DateTime(2025, 7, 27, 12), 
        to: DateTime(2025, 7, 27, 14, 30), 
        classID: 'aaa',
      ),
    ];
    notifyListeners();
    return appointments!;
  }
}
