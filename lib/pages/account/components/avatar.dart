import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarURL;
  const AvatarWidget({super.key, this.avatarURL});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: avatarURL == null
            ? Center(child: Icon(Icons.person, size: 120))
            : Image.network(
                avatarURL!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
