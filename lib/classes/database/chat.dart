import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/models/chat.dart';
import 'package:proxima/classes/models/user.dart';
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
    data['timestamp'] = FieldValue.serverTimestamp();
    final chatDoc = chats.doc(chatIDFrom(userIDs));
    await chatDoc.collection('messages').add(data);
    chatDoc.set({'userIDs': userIDs});
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
    final query = chats.where(
      'userIDs', arrayContains: currentUser.id,
    );
    final result = await query.get();
    List<User> otherUsers = [];

    for(final doc in result.docs){
      List<String> userIDs = (doc['userIDs'] as List).map((i) => '$i').toList();
      userIDs.remove(currentUser.id);
      final otherUser = await fetchUserFromID(userIDs.first);
      otherUsers.add(otherUser);
    }
    
    return otherUsers.map((otherUser){
      return Chat( 
        otherUser: otherUser,
        messages: [],
      );
    }).toList();
  }
}
