import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String? avatarURL;
  final String username;
  final String location;
  const UserInfo({
    super.key,
    this.avatarURL,
    required this.username,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 65,
            height: 65,
            child: Card(
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAlias,
              child: avatarURL == null
                  ? Icon(Icons.person, size: 45)
                  : Image.network(avatarURL!, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Card(
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person_pin_circle_outlined),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      SizedBox(width: 4,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
