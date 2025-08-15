import 'package:proxima/classes/models/user.dart';

final users = [
  nikolaNikolic,
  goranEdman,
  howieSimon,
  fredrikAkesson,
  ryotaHayami,
];

final nikolaNikolic = User(
  id: '4444-abc',
  range: 0.0,
  locationX: 21,
  locationY: 23,
  name: 'Nikola',
  avatarURL: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%2Fid%2FOIP.y_-RrO81dmnPR5dKO0GYWAHaHa%3Fpid%3DApi&f=1&ipt=b1838d508cf7ab8bd7cd26ec296ca178e050b871799c981492943e9b3b7e73a6&ipo=images",
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

final peraPeric = User(
  id: 'adsdas',
  range: 0.0,
  locationX: 51,
  locationY: 12,
  name: 'Pera',
  surname: 'Peric',
  interests: [
    'Engleski jezik',
    'Pecanje',
    'Ples'
  ],
  locationDesc: ['Brus', 'Srbija'],
  description: 'Volim engleski jezik i pecanje! Plesem kad upecam ribu, naravno! Ako zelis da naucis tehnike kvalitetnog ribolova, ili mozda da pricas engleski, javi se!'
);

final goranEdman = User(
  id: 'cc-5679-zz',
  range: 0.0,
  locationX: -22.302962,
  locationY: -49.061220,
  name: 'Goran',
  surname: 'Edman',
  interests: ['Music', 'Singing'],
);

final howieSimon = User(
  id: '34560-c4',
  range: 0.0,
  locationX: -22.304803,
  locationY: -49.062652,
  name: 'Howie',
  surname: 'Simon',
  interests: ['Music', 'Singing', 'Guitar'],
);

final fredrikAkesson = User(
  id: '65430-c55',
  range: 0.0,
  locationX: -22.295501,
  locationY: -49.055607,
  name: 'Fredrik',
  surname: 'Akesson',
  interests: ['Music', 'Singing', 'Guitar'],
);

final ryotaHayami = User(
  id: '34560-c4',
  range: 0.0,
  locationX: 35.679591,
  locationY: 139.770380,
  name: 'Ryota',
  surname: 'Hayami',
  interests: ['Music', 'Singing', 'Guitar'],
);
