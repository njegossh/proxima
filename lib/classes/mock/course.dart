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
  thumbnailURL: 'https://media.istockphoto.com/id/1219382595/vector/math-equations-written-on-a-blackboard.webp?s=1024x1024&w=is&k=20&c=FuAlO8n7UyfykyqpZMhWpQD66wIJuIbgXG7ZQPRgoPk=',
  pricePerHour: 10,
  description: "Uvod u svet C++ jezika. Posvecenost na visokom nivou. Dugogodisnji rad govori o uspehu! Prijavite se i necete se pokajati!"
);

final courseEng = Course(
  id: 'eng12',
  userID: '4',
  name: 'Engleski jezik',
  tags: [
    "Engleski",
    "Strani jezik"
  ],
  thumbnailURL: 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fthf.bing.com%2Fth%2Fid%2FOIP.N8Uigsj9ckf86RjPrHmNiQHaFS%3Fcb%3Dthfc1%26pid%3DApi&f=1&ipt=0db817d131670df553a7fa0d0ebad3e50bd599e9013849ec66bdf6829b060fc0&ipo=images',
  pricePerHour: 8,
  description: "Engleski jezik za sve uzraste!"
);