import 'package:flutter/material.dart';

class VideoCallController extends ChangeNotifier {

  String callIDFrom(List<String> userIDs){
    return (userIDs..sort()).join('_');
  }
}
