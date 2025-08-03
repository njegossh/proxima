import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarURL;
  const AvatarWidget({super.key, this.avatarURL});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Card(
        color: const Color.fromARGB(255, 245, 245, 250),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Colors.black, width: 3),
        ),
        child: avatarURL == null
            ? Icon(Icons.person, size: 150)
            : Image.network(avatarURL!),
      ),
    );
  }
}
