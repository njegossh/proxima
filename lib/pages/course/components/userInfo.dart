import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String? avatarURL;
  final String username;
  const UserInfo({super.key, this.avatarURL, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Container(
            width: 90,
            height: 90,
            child: Card(
              color: const Color.fromARGB(255, 245, 245, 250),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(color: Colors.black, width: 3),
              ),
              child: avatarURL == null
                  ? Icon(Icons.person, size: 70, color: Colors.indigo[600])
                  : Image.network(avatarURL!),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 8),
          child: Text(username, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
