import 'package:flutter/foundation.dart';
import 'package:proxima/classes/database/database.dart';
import 'user.dart';

class Course extends ChangeNotifier {
  String? id;
  String userID;
  String name;
  List<String> tags;
  double pricePerHour;
  double? averageReview;
  String? description;
  String? videoURL;
  String? thumbnailURL;
  String? thumbnailString;
  double locationX, locationY;

  User? user;

  Course({
    this.id,
    required this.name,
    required this.userID,
    required this.tags,
    required this.pricePerHour,
    required this.locationX,
    required this.locationY,
    this.description,
    this.averageReview,
    this.videoURL,
    this.thumbnailURL,
    this.thumbnailString,
    this.user,
  });

  static Course fromJson(Map json, String? id){
    return Course(
      id: id,
      name: json['name'] ?? '?',
      userID: json['userID'],
      tags: (json['tags'] as List? ?? []).map((i) => '$i').toList(),
      pricePerHour: json['pricePerHour'],
      averageReview: json['averageReview'],
      description: json['description'],
      videoURL: json['videoURL'],
      locationX: json['locationX'] ?? 0,
      locationY: json['locationY'] ?? 0,
      thumbnailURL: json['thumbnailURL'],
      thumbnailString: json['thumbnailString'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'userID': userID,
      'tags': tags,
      'pricePerHour': pricePerHour,
      'averageReview': averageReview,
      'description': description,
      'videoURL': videoURL,
      'locationX': locationX,
      'locationY': locationY,
      'thumbnailURL': thumbnailURL,
      'thumbnailString': thumbnailString,
    };
  }

  Future<void> reload() async {
    user = await Database().fetchUserFromID(userID);
    notifyListeners();
  }
}
