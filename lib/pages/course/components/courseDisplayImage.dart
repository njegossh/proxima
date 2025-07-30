import 'package:flutter/material.dart';

class Coursedisplayimage extends StatelessWidget {
  final String? displayImageURL;
  const Coursedisplayimage({super.key, this.displayImageURL});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.all(8),
        child: Center(child: displayImageURL == null ? Icon(Icons.image_rounded, size: 100, color: Colors.indigo[800],) : Image.network(displayImageURL!)),
      ),
    );
  }
}
