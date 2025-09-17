import 'package:flutter/material.dart';
import 'package:proxima/classes/database/database.dart';
import 'package:proxima/classes/models/chat.dart';

class ChatListController extends ChangeNotifier {
  List<Chat>? chatList;

  final searchController = TextEditingController();

  List<Chat> get filteredChatList {
    chatList?.sort((a, b){
      final aTime = a.lastMessage?.timestamp;
      if(aTime == null) return 1;
      final bTime = b.lastMessage?.timestamp;
      if(bTime == null) return -1;
      return bTime.compareTo(aTime);
    });
    return chatList?.where((chat) {
      final lowerQuery = searchController.text.toLowerCase();
      return chat.otherUser.fullName.toLowerCase().contains(lowerQuery);
    }).toList() ?? [];
  }

  Future<void> init() async {
    searchController.addListener(notifyListeners);
    chatList = await Database().fetchAllChats();
    for(final chat in chatList!){
      chat.openConnection();
      // Future.delayed(const Duration(seconds: 1)).then((_){
      //   chat.closeConnection();
      // });
      chat.addListener(notifyListeners);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.removeListener(notifyListeners);
    for(final chat in chatList ?? []){
      chat.removeListener(notifyListeners);
      chat.dispose();
    }
    super.dispose();
  }
}
