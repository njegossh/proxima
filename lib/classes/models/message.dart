import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/database/chat.dart';

import '../database.dart';

class Message {
  String? id;
  String fromUserID, toUserID;
  String message;
  Timestamp timestamp;

  Message({
    this.id,
    required this.fromUserID,
    required this.toUserID,
    required this.message,
    required this.timestamp,
  });

  static Message fromJson(Map json, String? id){
    return Message( 
      id: id,
      fromUserID: json['fromUserID'],
      toUserID: json['toUserID'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fromUserID': fromUserID,
      'toUserID': toUserID,
      'message': message,
      'timestamp': timestamp,
    };
  }

  Future<void> send() => Database().sendMessage(
    [fromUserID, toUserID], 
    toMap(),
  );
}
