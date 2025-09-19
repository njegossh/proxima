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

  List<Message> _messages = [];
  
  List<Message> get messages {
    _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return List.unmodifiable(_messages);
  }
  
  User get otherUser => chat.otherUser;

  static ChatController fromOtherUser(User otherUser){
    return ChatController(chat: Chat(
      otherUser: otherUser,
      messages: [],
    ));
  }
  
  ChatController({required this.chat}){
    _messages = List.from(chat.messages);
    chat.openConnection();
    chat.addListener(_handleChatUpdate);
    
    WidgetsBinding.instance.addObserver(_KeyboardObserver(this));
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottomIfNeeded(animate: false);
    });
  }

  void _handleChatUpdate() {
    _messages = List.from(chat.messages);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottomIfNeeded(animate: true);
      
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottomIfNeeded(animate: false);
      });
    });
    
    notifyListeners();
  }

  void _scrollToBottomIfNeeded({bool animate = true}) {
    if (!scroll.hasClients) return;
    
    Future.delayed(const Duration(milliseconds: 50), () {
      if (!scroll.hasClients) return;
      
      final maxScroll = scroll.position.maxScrollExtent;
      if (maxScroll <= 0) return;
      
      if (animate) {
        scroll.animateTo(
          maxScroll,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        scroll.jumpTo(maxScroll);
      }
    });
  }

  void _onKeyboardChanged() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottomIfNeeded(animate: true);
    });
  }

  Future<void> send() async {
    if(input.text.isEmpty) return;
    
    final messageContent = input.text;
    input.clear();
    
    final message = Message(
      fromUserID: currentUser.id,
      toUserID: chat.otherUser.id,
      content: messageContent,
      timestamp: Timestamp.now(),
    );
    
    try {
      await message.send();
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to send message: $e');
      input.text = messageContent;
    }
  }

  void scrollToBottom() {
    _scrollToBottomIfNeeded(animate: true);
  }

  @override
  void dispose() {
    chat.removeListener(_handleChatUpdate);
    chat.dispose();
    scroll.dispose();
    input.dispose();
    super.dispose();
  }
}

class _KeyboardObserver extends WidgetsBindingObserver {
  final ChatController controller;
  double? _lastInset;

  _KeyboardObserver(this.controller);

  @override
  void didChangeMetrics() {
    final currentInset = WidgetsBinding.instance.platformDispatcher.views.first.viewInsets.bottom;
    
    if (_lastInset != null && _lastInset != currentInset) {
      controller._onKeyboardChanged();
    }
    
    _lastInset = currentInset;
  }
}

extension PrettyDate on Timestamp {
  String get prettified => toDate().prettified;
}