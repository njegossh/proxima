import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/appointment.dart';
import 'appointment.dart';

class User extends ChangeNotifier {
  String? id;
  double locationX, locationY;
  List<String>? locationDesc;
  String name, surname;
  String? description;
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
      appointment1, appointment2, appointment4,
    ];
    notifyListeners();
    return appointments!;
  }
}
