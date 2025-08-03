import 'package:flutter/material.dart';
import 'package:proxima/classes/mock/user.dart';
import 'package:proxima/pages/chat/components/input.dart';
import 'package:proxima/pages/chat/controller.dart';

import 'components/messages.dart';

class ChatMainPage extends StatefulWidget {
  const ChatMainPage({super.key});

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  final otherUser = goranEdman;
  late ChatController controller;

  @override
  void initState() {
    controller = ChatController.fromOtherUser(
      otherUser,
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold( 
          appBar: AppBar(
            title: Text(otherUser.fullName),
          ),
          bottomSheet: ChatInput(controller: controller),
          body: Column(
            children: [
              Expanded(
                child: ChatMessages(
                  controller: controller,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
