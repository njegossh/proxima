import 'package:proxima/classes/models/course.dart';

final courses = [
  courseCPP,
  courseEng
];

final courseCPP = Course(
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
  ],
  videoURL: 'https://youtu.be/LozsKQQRPkU?si=oUAEC-8IBcsN9Syf',
  pricePerHour: 10,
  description: "Uvod u svet C++ jezika. Posvecenost na visokom nivou. Dugogodisnji rad govori o uspehu! Prijavite se i necete se pokajati!",
  locationX: 21,
  locationY: 21
);

final courseEng = Course(
  id: 'eng12',
  userID: '4',
  name: 'Engleski jezik',
  tags: [
    "Engleski",
    "Strani jezik"
  ],
  pricePerHour: 8,
  description: "Engleski jezik za sve uzraste!",
  locationX: 21,
  locationY: 21
);