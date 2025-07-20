import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarURL;
  const AvatarWidget({
    super.key,
    this.avatarURL,
  });

  @override
  Widget build(BuildContext context) {
    if(avatarURL == null){
      return Icon(Icons.person);
    } else {
      return Image.network(avatarURL!);
    }
  }
}
