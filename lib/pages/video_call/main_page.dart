import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/video_call/controller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:proxima/config/zego_ui_options.dart';

class VideoCallMainPage extends StatefulWidget {
  final User otherUser;
  const VideoCallMainPage({super.key, required this.otherUser});

  @override
  State<VideoCallMainPage> createState() => _VideoCallMainPageState();
}

class _VideoCallMainPageState extends State<VideoCallMainPage> {
  late VideoCallController controller;

  @override
  void initState() {
    controller = VideoCallController(otherUser: widget.otherUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: ZegoUIOptions.currentOptions.appId,
      callID: controller.callID,
      userID: currentUser.id,
      userName: currentUser.fullName,
      config: ZegoUIKitPrebuiltCallConfig(turnOnCameraWhenJoining: false),
      appSign: ZegoUIOptions.currentOptions.appSign,
    );
  }
}
