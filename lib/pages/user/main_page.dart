import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'components/avatar.dart';

final mockUser = User(
  locationX: 3123, 
  locationY: 34234, 
  name: 'Nikola', 
  surname: 'Nikolic', 
  interests: [ 'Sah', 'Programiranje' ],
  locationDesc: [ 'Srbija', 'Nis' ],
  description: 'Opis profila',
  avatarURL: null,
);

class UserMainPage extends StatelessWidget {
  const UserMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text(mockUser.fullName),
      ),
      body: Column( 
        children: [
          AvatarWidget(
            avatarURL : mockUser.avatarURL,
          ),
        ],
      ),
    );
  }
}
