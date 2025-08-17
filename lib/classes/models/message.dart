import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/database/database.dart';

class Message {
  String? id;
  String fromUserID, toUserID;
  String content;
  Timestamp timestamp;

  Message({
    this.id,
    required this.fromUserID,
    required this.toUserID,
    required this.content,
    required this.timestamp,
  });

  static Message fromJson(Map json, String? id){
    return Message( 
      id: id,
      fromUserID: json['fromUserID'],
      toUserID: json['toUserID'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'fromUserID': fromUserID,
      'toUserID': toUserID,
      'content': content,
      'timestamp': timestamp,
    };
  }

  Future<void> send() => Database().sendMessage(
    [fromUserID, toUserID], 
    toMap(),
  );
}
