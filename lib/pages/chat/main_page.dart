import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/chat.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/chat/components/input.dart';
import 'package:proxima/pages/chat/controller.dart';
import 'components/messages.dart';

class ChatMainPage extends StatefulWidget {
  final User otherUser;
  final Chat? chat;
  const ChatMainPage({super.key, required this.otherUser, this.chat});

  @override
  State<ChatMainPage> createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {
  late ChatController controller;

  @override
  void initState() {
    if (widget.chat == null) {
      controller = ChatController.fromOtherUser(widget.otherUser);
    } else {
      controller = ChatController(chat: widget.chat!);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.chat == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  foregroundImage: MemoryImage(
                    base64Decode(controller.otherUser.imageString ?? ''),
                  ),
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 12),
                Text(widget.otherUser.fullName),
              ],
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ChatInput(controller: controller),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: Column(
              children: [Expanded(child: ChatMessages(controller: controller))],
            ),
          ),
        );
      },
    );
  }
}
