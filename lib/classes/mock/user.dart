import 'package:proxima/classes/models/user.dart';

final users = [
  nikolaNikolic,
  goranEdman,
  howieSimon,
  fredrikAkesson,
  ryotaHayami,
];

final nikolaNikolic = User(
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
);

final goranEdman = User(
  id: 'cc-5679-zz',
  locationX: -22.302962,
  locationY: -49.061220,
  name: 'Goran',
  surname: 'Edman',
  interests: ['Music', 'Singing'],
);

final howieSimon = User(
  id: '34560-c4',
  locationX: -22.304803,
  locationY: -49.062652,
  name: 'Howie',
  surname: 'Simon',
  interests: ['Music', 'Singing', 'Guitar'],
);

final fredrikAkesson = User(
  id: '65430-c55',
  locationX: -22.295501,
  locationY: -49.055607,
  name: 'Fredrik',
  surname: 'Akesson',
  interests: ['Music', 'Singing', 'Guitar'],
);

final ryotaHayami = User(
  id: '34560-c4',
  locationX: 35.679591,
  locationY: 139.770380,
  name: 'Ryota',
  surname: 'Hayami',
  interests: ['Music', 'Singing', 'Guitar'],
);
