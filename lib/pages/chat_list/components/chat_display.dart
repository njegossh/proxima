import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/chat.dart';
import 'package:proxima/pages/chat/main_page.dart';
import 'package:proxima/pages/user/main_page.dart';

class ChatDisplay extends StatelessWidget {
  final Chat chat;
  const ChatDisplay({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatMainPage(otherUser: chat.otherUser, chat: chat);
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserMainPage(user: chat.otherUser);
                      },
                    ),
                  );
                },
                child: SizedBox(
                  width: 65,
                  height: 65,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    clipBehavior: Clip.antiAlias,
                    child: chat.otherUser.imageString == null
                        ? Icon(Icons.person, size: 45)
                        : Image.memory(
                            base64Decode(chat.otherUser.imageString!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.otherUser.fullName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    chat.messages.isNotEmpty
                        ? Text(
                            chat.messages.last.content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        : Text(
                            "Jos uvek nema poruka.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                  ],
                ),
              ),
              Spacer(),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
