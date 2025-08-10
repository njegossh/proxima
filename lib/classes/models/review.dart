class Review {
  String? id;
  String userID, courseID;
  double value;
  String comment;
  DateTime date;

  Review({
    this.id,
    required this.userID,
    required this.courseID,
    required this.value,
    required this.comment,
    required this.date,
  });

  static Review fromJson(Map json, String? id) {
    return Review( 
      id: id,
      userID: json['userID'],
      courseID: json['courseID'],
      value: json['value'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, Object> toJson() {
    return {
      'userID': userID,
      'courseID': courseID,
      'value': value,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}
