import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proxima/classes/database/chat.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/main.dart';
import 'message.dart';
import 'user.dart';

class Chat extends ChangeNotifier {
  StreamSubscription? connection;

  User otherUser;
  List<Message> messages;

  Chat({
    required this.otherUser,
    required this.messages,
  });

  Future<void> openConnection() async {
    connection = Database().openChatConnection([
      currentUser.id!,
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
