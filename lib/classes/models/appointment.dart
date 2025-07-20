import 'class.dart';

class Appointment {
  String? id;
  DateTime from, to;
  String classID;

  Appointment({
    this.id,
    required this.from,
    required this.to,
    required this.classID,
  });

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

  Future<Class> getClass() async {
    throw UnimplementedError();
  }
}
