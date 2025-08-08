import 'package:proxima/classes/models/review.dart';

final reviews = [
  Review(
    userID: '34560-c4',
    classID: 'prog123',
    value: 4.5,
    comment: 'Profesor odlično prenosi znanje, sve pohvale!',
    date: DateTime(2025, 8, 3),
  ),
  Review(
    userID: '4444-abc',
    classID: 'prog123',
    value: 5.0,
    comment: 'Predavanja su jasna i zanimljiva, materijal odlično pripremljen.',
    date: DateTime(2025, 8, 2),
  ),
  Review(
    userID: 'cc-5679-zz',
    classID: 'eng12',
    value: 4.0,
    comment: 'Dobro objašnjava, ali bih voleo više primera iz prakse.',
    date: DateTime(2025, 8, 1),
  ),
  Review(
    userID: '34560-c4',
    classID: 'eng12',
    value: 3.8,
    comment: 'Lep pristup predavanjima, ali tempo je pomalo brz.',
    date: DateTime(2025, 8, 4),
  ),
  Review(
    userID: '4444-abc',
    classID: 'prog123',
    value: 4.7,
    comment: 'Vrlo motivišući profesor, rado pomaže i van časa.',
    date: DateTime(2025, 8, 5),
  ),
];
