class Report {
  String? id;
  String fromUserID, toUserID;
  String desc;
  DateTime date;

  Report({
    this.id,
    required this.fromUserID,
    required this.toUserID,
    required this.desc,
    required this.date,
  });

  static Report fromJson(Map json, String? id){
    return Report( 
      id: id,
      fromUserID: json['fromUserID'],
      toUserID: json['toUserID'],
      desc: json['desc'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'fromUserID': fromUserID,
      'toUserID': toUserID,
      'desc': desc,
      'date': date.toIso8601String(),
    };
  }
}
