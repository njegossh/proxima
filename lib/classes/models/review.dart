class Review {
  String? id;
  String userID, classID;
  double value;
  String comment;
  DateTime date;

  Review({
    this.id,
    required this.userID,
    required this.classID,
    required this.value,
    required this.comment,
    required this.date,
  });

  static Review fromJson(Map json, String? id){
    return Review( 
      id: id,
      userID: json['userID'],
      classID: json['classID'],
      value: json['value'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

}
