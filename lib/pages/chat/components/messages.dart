import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import '../controller.dart';

class ChatMessages extends StatelessWidget {
  final ChatController controller;
  const ChatMessages({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final messages = controller.messages;
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      controller: controller.scroll,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final mine = message.fromUserID == currentUser.id;
        final colorScheme = Theme.of(context).colorScheme;

        return Container(
          padding: EdgeInsets.only(
            bottom: 8, 
            left: mine ? 64 : 0,
            right: mine ? 0 : 64,
          ),
          child: Column(
            crossAxisAlignment: mine
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: mine ? colorScheme.primary : colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.content,
                      style: TextStyle(
                        color: mine
                            ? colorScheme.secondary
                            : colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message.timestamp.prettified,
                      style: TextStyle(
                        color: (mine ? colorScheme.secondary : colorScheme.primary)
                            .withAlpha(150),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}