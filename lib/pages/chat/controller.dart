import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/chat.dart';
import 'package:proxima/classes/models/message.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/appointment_creation/controller.dart';

class ChatController extends ChangeNotifier {
  final Chat chat;
  final scroll = ScrollController();
  final input = TextEditingController();

  List<Message> get messages => chat.messages;
  User get otherUser => chat.otherUser;

  static ChatController fromOtherUser(User otherUser){
    return ChatController(chat: Chat(
      otherUser: otherUser,
      messages: [],
    ));
  }
  
  ChatController({required this.chat}){
    chat.openConnection();
    chat.addListener((){
      scroll.animateTo(
        scroll.position.maxScrollExtent, 
        duration: const Duration(seconds: 1), 
        curve: Curves.easeIn,
      );
      notifyListeners();
    });
  }

  Future<void> send() async {
    if(input.text.isEmpty) return;
    final message = Message(
      fromUserID: currentUser.id,
      toUserID: chat.otherUser.id,
      content: input.text,
      timestamp: Timestamp.now(),
    );
    input.clear();
    await message.send();
    notifyListeners();
  }

  @override
  void dispose() {
    chat.dispose();
    super.dispose();
  }
}

extension PrettyDate on Timestamp {
  String get prettified => toDate().prettified;
}
