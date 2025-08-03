import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'components/avatar.dart';
import 'components/interestChips.dart';



class UserMainPage extends StatelessWidget {
  const UserMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding( // PROFILNA SLIKA
            padding: EdgeInsets.only(top: 48, bottom: 32),
            child: Center(child: AvatarWidget(avatarURL: mockUser.avatarURL)),
          ),
          Align( //IME I PREZIME
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Text(
                "${mockUser.fullName}",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align( //LOKACIJA
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top:8, bottom: 16, left: 16, right: 16),
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.black)
                ),
                backgroundColor: Colors.white,
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_pin_circle_outlined,color: Colors.blueAccent),
                    Text(
                      mockUser.locationDesc != null
                          ? mockUser.locationDesc!.join(", ")
                          : "Nema podataka za lokaciju.",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding( //INTERESOVANJA
            padding: EdgeInsets.only(top: 4, right: 16, left: 16),
            child: InterestChips(listOfInterests: mockUser.interests),
          ),
          Align( //DESKRIPCIJA PROFILA
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
                    child: Text(
                      "${mockUser.description}",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
