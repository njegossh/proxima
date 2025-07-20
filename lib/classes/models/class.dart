class Class { //heh
  String? id;
  String userID;
  List<String> tags;
  double pricePerHour;
  double? averageReview;

  Class({
    this.id,
    required this.userID,
    required this.tags,
    required this.pricePerHour,
    this.averageReview,
  });

  static Class fromJson(Map json, String? id){
    return Class(
      id: id,
      userID: json['userID'],
      tags: json['tags'],
      pricePerHour: json['pricePerHour'],
      averageReview: json['averageReview'],
    );
  }
}
