import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
//import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
//import 'package:proxima/zego_ui_options.dart';

final User exampleUser1 = User(
  id: 'cc-5679-zz',
  locationX: 57.35009,
  locationY: 13.74389,
  name: 'Goran',
  surname: 'Edman',
  interests: ['Music', 'Singing'],
);

final User exampleUser2 = User(
  id: '34560-c4',
  locationX: 35.679591,
  locationY: 139.770380,
  name: 'Ryota',
  surname: 'Hayami',
  interests: ['Music', 'Singing', 'Guitar'],
);

final String exampleCallId = 'c3-b6';

class VideoCallMainPage extends StatelessWidget {
  const VideoCallMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    /*
    return ZegoUIKitPrebuiltCall(
      appID: ZegoUIOptions.currentOptions.appId,
      callID: exampleCallId,
      userID: exampleUser1.id ?? '3565',
      userName: exampleUser1.fullName,
      config: ZegoUIKitPrebuiltCallConfig(turnOnCameraWhenJoining: false),
      appSign: ZegoUIOptions.currentOptions.appSign,
    );
    */
  }
}
