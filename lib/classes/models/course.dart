import 'package:flutter/foundation.dart';
import 'package:proxima/classes/mock/user.dart';
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
  User? user;

  Course({
    this.id,
    required this.name,
    required this.userID,
    required this.tags,
    required this.pricePerHour,
    this.description,
    this.averageReview,
    this.videoURL,
    this.thumbnailURL,
  });

  static Course fromJson(Map json, String? id){
    return Course(
      id: id,
      name: json['name'],
      userID: json['userID'],
      tags: json['tags'],
      pricePerHour: json['pricePerHour'],
      averageReview: json['averageReview'],
      description: json['description'],
      videoURL: json['videoURL'],
    );
  }

  Future<void> reload() async {
    await Future.delayed(const Duration(seconds: 1));
    user = nikolaNikolic;
    notifyListeners();
  }
}
