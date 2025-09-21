import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'components/chat_display.dart';
import 'controller.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final controller = ChatListController();

  @override
  void initState() {
    super.initState();
    controller.init();
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
        if (controller.chatList == null) CircularProgressIndicator();

        return  Column(
            children: [
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Serach".tr,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: controller.filteredChatList.isEmpty
                    ? Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 50,),
                        Text("No results!".tr),
                      ],
                    ))
                    : ListView.separated(
                        itemCount: controller.filteredChatList.length,
                        itemBuilder: (context, index) {
                          final chat = controller.filteredChatList[index];
                          return ChatDisplay(chat: chat);
                        },
                        separatorBuilder: (_, i) => SizedBox(height: 8),
                      ),
              ),
            ],
        );
      },
    );
  }
}
