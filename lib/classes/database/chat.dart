import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/chat.dart';
import 'package:proxima/main.dart';
import '../models/message.dart';
import 'database.dart';

extension ChatDatabase on Database {

  String chatIDFrom(List<String> userIDs){
    return (userIDs..sort()).join('_');
  }

  CollectionReference get chats => firestore.collection('chats');
  
  Future<void> sendMessage(
    List<String> userIDs, 
    Map<String, dynamic> data,
  ) async {
    final chatDoc = chats.doc(chatIDFrom(userIDs));
    await chatDoc.collection('messages').add(data);
  }

  Stream<List<Message>> openChatConnection(List<String> userIDs){
    final chatDoc = chats.doc(chatIDFrom(userIDs));
    final query = chatDoc.collection('messages').orderBy(
      'timestamp', descending: false,
    );
    return query.snapshots().map((snap){
      return snap.docs.map((doc){
       return Message.fromJson(doc.data(), doc.id); 
      }).toList();
    });
  }

  Future<List<Chat>> fetchAllChats() async {
    if(currentUser.followedUsers == null){
      await currentUser.reloadFollowedUsers();
    }
    return currentUser.followedUsers?.map((user){
      return Chat(
        otherUser: user, 
        messages: [],
      );
    }).toList() ?? [];
  }
}
