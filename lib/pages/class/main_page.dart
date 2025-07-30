import 'package:flutter/material.dart';
import 'package:proxima/classes/models/class.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/pages/class/components/courseDisplayImage.dart';
import 'package:proxima/pages/class/components/tagsChips.dart';
import 'package:proxima/pages/class/components/userInfo.dart';
import 'package:proxima/pages/class/components/videoShowcase.dart';
import 'package:proxima/pages/user/components/interestChips.dart';

final mockCourse = Class(
  id: 'prog123',
  userID: '4',
  name: 'Programiranje u C++',
  tags: [
    "Programiranje",
    "C++",
    "Coding",
    "Racunar",
    "PC",
    "Software",
  ], //Nepotrebni tagovi cisto za display
  pricePerHour: 2000, //U dinarima recimo
);

final mockUser = User(
  //Usera dobavljamo preko userID ali za sad cemo idalje mockUser-a
  locationX: 3123,
  locationY: 34234,
  name: 'Nikola',
  surname: 'Nikolic',
  interests: [
    'Sah',
    'Programiranje',
    'Plivanje',
    'Guslanje',
    'Strani jezici',
    'Planinarenje',
    'Matematika',
  ],
  locationDesc: ['Nis', 'Srbija'],
  description:
      'Opis profila. Samo i iskljucivo u svrhe testiranja. Ovaj tekst ne sadrzi nikakve znacajne informacije i iskljucivo se koristi kao reprezentativan primer opisa profila nekog korisnika. Trudimo se da ovaj opis bude dovoljno opsiran.',
  avatarURL: null,
);

class ClassMainPage extends StatelessWidget {
  ClassMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.indigo[500],
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              //NAZIV KURSA
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 48, bottom: 24),
                child: Text(
                  "${mockCourse.name}",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              // GLAVNA SLIKA
              padding: EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
              child: Coursedisplayimage(displayImageURL: mockUser.showcaseUrl),
            ),
            Padding(
              // TAGOVI KURSA
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 4),
              child: TagsChips(listOfInterests: mockCourse.tags),
            ),
            Padding(
              // INFORMACIJE INSTRUKTORA
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                right: 4,
                left: 4,
              ),
              child: UserInfo(username: mockUser.fullName),
            ),
            Align(
              // DESKRIPCIJA KURSA : DODATI ATRIBUT ZA DESKRIPCIJU KURSA!
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        "Description to be addded!",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding( // VIDEO O KURSU : TO BE ADDED!
              padding: const EdgeInsets.all(4),
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 100,
                child: Card(child: Center(child: Text("To be added: Video showcase"))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
