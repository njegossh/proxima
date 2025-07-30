class Course { //heh
  String? id;
  String userID;
  String name;
  List<String> tags;
  double pricePerHour;
  double? averageReview;

  Course({
    this.id,
    required this.name,
    required this.userID,
    required this.tags,
    required this.pricePerHour,
    this.averageReview,
  });

  static Course fromJson(Map json, String? id){
    return Course(
      id: id,
      name: json['name'],
      userID: json['userID'],
      tags: json['tags'],
      pricePerHour: json['pricePerHour'],
      averageReview: json['averageReview'],
    );
  }
}

final mockCourses = [
  Course(
    id: 'aaa',
    userID: '',
    name: 'Sah',
    tags: [], 
    pricePerHour: 32,
  ),
  Course(
    id: 'bbb',
    userID: '',
    name: 'Muzika',
    tags: [], 
    pricePerHour: 32,
  ),
  Course(
    id: 'ccc',
    userID: '',
    name: 'Odmaranje',
    tags: [], 
    pricePerHour: 32,
  ),
];
