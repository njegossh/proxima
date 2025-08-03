import 'package:flutter/material.dart';
import '../controller.dart';

class ChatInput extends StatelessWidget {
  final ChatController controller;
  const ChatInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
        child: Row(
          children: [
            Expanded(
              child: TextField( 
                controller: controller.input,
                onSubmitted: (val) => controller.send(),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: controller.send, 
              icon: Icon(Icons.keyboard_return_rounded),
            )
          ],
        ),
      ),
    );
  }
}
