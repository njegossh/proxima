import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/chat/components/input.dart';
import 'package:proxima/pages/chat/controller.dart';
import 'components/messages.dart';

class ChatMainPage extends StatefulWidget {
  final User otherUser;
  const ChatMainPage({super.key, required this.otherUser});

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  late ChatController controller;

  @override
  void initState() {
    controller = ChatController.fromOtherUser(
      widget.otherUser,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold( 
          appBar: AppBar(
            title: Text(widget.otherUser.fullName),
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
