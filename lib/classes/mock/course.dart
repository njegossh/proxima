import 'package:proxima/classes/models/course.dart';

final courses = [
  courseCPP,
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
  ], //Nepotrebni tagovi cisto za display
  videoURL: 'https://youtu.be/LozsKQQRPkU?si=oUAEC-8IBcsN9Syf',
  thumbnailURL: 'https://media.istockphoto.com/id/1219382595/vector/math-equations-written-on-a-blackboard.webp?s=1024x1024&w=is&k=20&c=FuAlO8n7UyfykyqpZMhWpQD66wIJuIbgXG7ZQPRgoPk=',
  pricePerHour: 10,
);
