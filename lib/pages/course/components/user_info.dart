import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/user/main_page.dart';

class UserInfo extends StatelessWidget {
  final User user;
  const UserInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserMainPage(user: user);
        }));
      },
      child: Padding(
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
                child: user.avatarURL == null
                    ? Icon(Icons.person, size: 45)
                    : Image.network(user.avatarURL!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
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
                          user.formmatedLocationDesc,
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
      ),
    );
  }
}
