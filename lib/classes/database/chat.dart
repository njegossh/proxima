import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import '../models/message.dart' show Message;
import 'database.dart' show Database;

extension ChatDatabase on Database {

  String chatIDFrom(List<String> userIDs){
    return (userIDs..sort()).join('_');
  }

  DocumentReference chatReference(String chatID){
    return firestore.collection('chats').doc(chatID);
  }
  
  Future<void> sendMessage(
    List<String> userIDs, 
    Map<String, dynamic> data,
  ) async {
    final chatDoc = chatReference(chatIDFrom(userIDs));
    await chatDoc.collection('messages').add(data);
  }

  Stream<List<Message>> openChatConnection(List<String> userIDs){
    final chatDoc = chatReference(chatIDFrom(userIDs));
    final query = chatDoc.collection('messages').orderBy(
      'timestamp', descending: false,
    );
    return query.snapshots().map((snap){
      return snap.docs.map((doc){
       return Message.fromJson(doc.data(), doc.id); 
      }).toList();
    });
  }
}
