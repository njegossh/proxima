import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarURL;
  final String? imageString;
  const AvatarWidget({super.key, this.avatarURL, this.imageString});

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
        child: _conditionalImage(),
      ),
    );
  }

  Widget _conditionalImage() {
    if (imageString != null && imageString!.isNotEmpty) {
      try {
        final Uint8List bytes = base64Decode(imageString!);
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      } catch (e) {
        debugPrint("Error decoding Base64 string: $e");
      }
    }
    if (avatarURL != null && avatarURL!.isNotEmpty) {
      return Image.network(
        avatarURL!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            width: double.infinity,
            child: Icon(Icons.error_outline, size: 100),
          );
        },
      );
    }

    return const SizedBox(
      width: double.infinity,
      child: Icon(Icons.person, size: 100),
    );
  }
}
