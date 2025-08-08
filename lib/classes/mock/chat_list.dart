import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proxima/classes/mock/user.dart' as user;
import 'package:proxima/classes/models/chat.dart';
import 'package:proxima/classes/models/message.dart';

final List<Chat> mockChatList = [
  chat1,
  chat2,
  chat3,
  chat4,
  chat5
];


final chat1 = Chat(
  otherUser: user.nikolaNikolic,
  messages: messages1
);

final messages1 = [
  message1,
  message2
];

final message2 = Message(fromUserID: "4444-abc", toUserID: "abcd", content: "platices mi kad tad", timestamp: Timestamp(2341, 2412));
final message1 = Message(fromUserID: "4444-abc", toUserID: "abcd", content: "je l me cujes", timestamp: Timestamp(62643,4361));

final chat2 = Chat(
  otherUser: user.fredrikAkesson,
  messages: List.empty()
);

final chat3 = Chat(
  otherUser: user.goranEdman,
  messages: List.empty()
);

final chat4 = Chat(
  otherUser: user.peraPeric,
  messages: List.empty()
);

final chat5 = Chat(
  otherUser: user.ryotaHayami,
  messages: List.empty()
);