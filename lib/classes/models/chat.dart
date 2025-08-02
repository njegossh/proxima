import 'dart:async';
import 'package:flutter/material.dart';
import '../database/chat.dart';
import '../database.dart';
import 'message.dart';
import 'user.dart';

class Chat extends ChangeNotifier {
  StreamSubscription? connection;

  User thisUser, otherUser;
  List<Message> messages;

  Chat({
    required this.thisUser,
    required this.otherUser,
    required this.messages,
  });

  Future<void> openConnection() async {
    connection = Database().openChatConnection([
      thisUser.id!,
      otherUser.id!,
    ]).listen(( newMessages ){
      //TODO proveriti
      messages = newMessages;
    });
  }

  void closeConnection(){
    connection?.cancel();
  }
}
