import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarURL;
  const AvatarWidget({super.key, this.avatarURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Card(
        child: avatarURL == null
            ? Icon(Icons.person, size: 150, color: const Color.fromARGB(255, 30, 100, 66),)
            : Image.network(avatarURL!),
        color: const Color.fromARGB(255, 245, 245, 250),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: Colors.black, width: 3),
        ),
      ),
    );
  }
}
