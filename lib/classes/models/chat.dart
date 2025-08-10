import 'dart:async';
import 'package:flutter/material.dart';
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
      currentUser.id,
      otherUser.id,
    ]).listen(appendNewMessages);
  }

  void closeConnection(){
    connection?.cancel();
  }

  void appendNewMessages(List<Message> newMessages){
    debugPrint('${newMessages.length} new messages!');
    for(final newMessage in newMessages){
      final isNew = messages.indexWhere((message){
        return message.id == newMessage.id;
      }) < 0;

      if( isNew ) messages.add(newMessage);
    }
    messages.sort((a, b) { 
      return a.timestamp.compareTo(b.timestamp);
    });
    notifyListeners();
  }
}
