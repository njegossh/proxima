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
        child: Image.network(
          avatarURL ?? '',
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) {
            return SizedBox(
              width: double.infinity,
              child: Icon(Icons.image_rounded, size: 100),
            );
          },
        ),
      ),
    );
  }
}
