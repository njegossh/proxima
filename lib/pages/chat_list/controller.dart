import 'package:flutter/material.dart';
import 'package:proxima/classes/models/chat.dart';
import 'package:proxima/classes/mock/chat_list.dart';

class ChatListController extends ChangeNotifier {
  List<Chat> chatList = [];
  List<Chat> filteredChatList = [];
  bool isLoading = false;

  Future<List<Chat>> fetchChats() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));
    chatList = List.from(mockChatList);
    filteredChatList = List.from(chatList);

    isLoading = false;
    notifyListeners();

    return chatList;
  }

  Future<void> init() async {
    await fetchChats();
  }

  void filterChats(String query) {
    final lowerQuery = query.toLowerCase();

    filteredChatList = chatList.where((chat) {
      return chat.otherUser.fullName.toLowerCase().contains(lowerQuery);
    }).toList();

    notifyListeners();
  }
}
