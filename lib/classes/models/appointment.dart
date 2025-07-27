import 'dart:math';

import 'package:flutter/material.dart';
import 'class.dart';

class Appointment extends ChangeNotifier {
  String? id;
  DateTime from, to;
  String classID;
  Class? classe;

  Appointment({
    this.id,
    this.classe,
    required this.from,
    required this.to,
    required this.classID,
  });

  String get name {
    if(classe == null) load();
    return classe?.name ?? '?';
  }

  static Appointment fromJson(Map json, String? id){
    return Appointment(
      id: id,
      from: DateTime.parse(json['from'] ?? ''), 
      to: DateTime.parse(json['to'] ?? ''), 
      classID: json['classID'],
    );
  }

  Map toJson(){
    return {
      'from' : from.toIso8601String(),
      'to': to.toIso8601String(),
      'classID': classID,
    };
  }

  Future load() async {
    if(classe == null) reloadClass();
  }

  Future reloadClass() async {
    classe = mockClasses.firstWhere((classe){
      return classe.id == classID;
    });
  }
}
