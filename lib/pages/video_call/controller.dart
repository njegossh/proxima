import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';

class VideoCallController extends ChangeNotifier {
  final User otherUser;

  VideoCallController({required this.otherUser});

  String get callID {
    return ([otherUser, currentUser]..sort()).join('_');
  }
}
