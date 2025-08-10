import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/video_call/controller.dart';
//import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
//import 'package:proxima/zego_ui_options.dart';

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
    return Container();
    /*
    return ZegoUIKitPrebuiltCall(
      appID: ZegoUIOptions.currentOptions.appId,
      callID: controller.callIDFrom([goranEdman.id, howieSimon.id]),
      userID: goranEdman.id ?? '3565',
      userName: goranEdman.fullName,
      config: ZegoUIKitPrebuiltCallConfig(turnOnCameraWhenJoining: false),
      appSign: ZegoUIOptions.currentOptions.appSign,
    );
    */
  }
}
