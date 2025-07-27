class Class { //heh
  String? id;
  String userID;
  String name;
  List<String> tags;
  double pricePerHour;
  double? averageReview;

  Class({
    this.id,
    required this.name,
    required this.userID,
    required this.tags,
    required this.pricePerHour,
    this.averageReview,
  });

  static Class fromJson(Map json, String? id){
    return Class(
      id: id,
      name: json['name'],
      userID: json['userID'],
      tags: json['tags'],
      pricePerHour: json['pricePerHour'],
      averageReview: json['averageReview'],
    );
  }
}

final mockClasses = [
  Class(
    id: 'aaa',
    userID: '',
    name: 'Sah',
    tags: [], 
    pricePerHour: 32,
  ),
  Class(
    id: 'bbb',
    userID: '',
    name: 'Muzika',
    tags: [], 
    pricePerHour: 32,
  ),
  Class(
    id: 'ccc',
    userID: '',
    name: 'Odmaranje',
    tags: [], 
    pricePerHour: 32,
  ),
];
