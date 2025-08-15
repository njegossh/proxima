import 'package:flutter/material.dart';

class Coursedisplayimage extends StatelessWidget {
  final String? displayImageURL;
  const Coursedisplayimage({super.key, this.displayImageURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(0),
        child: SizedBox(
          height: 200,
          child: displayImageURL == null ? Icon(
            Icons.image_rounded, 
            size: 100,
          ) : Image.network(displayImageURL!, fit: BoxFit.cover,),
        ),
      ),
    );
  }
}
