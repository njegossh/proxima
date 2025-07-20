class Message {
  String? id;
  String fromUserID, toUserID;
  String message;
  DateTime date;

  Message({
    this.id,
    required this.fromUserID,
    required this.toUserID,
    required this.message,
    required this.date,
  });

  static Message fromJson(Map json, String? id){
    return Message( 
      id: id,
      fromUserID: json['fromUserID'],
      toUserID: json['toUserID'],
      message: json['message'],
      date: DateTime.parse(json['date']),
    );
  }
}
