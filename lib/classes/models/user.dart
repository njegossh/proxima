class User {
  String? id;
  double locationX, locationY;
  List<String>? locationDesc;
  String name, surname;
  String? description;
  String? showcaseUrl;
  String? avatarURL; //TODO
  List<String> interests;

  User({
    this.id,
    required this.locationX,
    required this.locationY,
    this.locationDesc,
    required this.name,
    required this.surname,
    this.avatarURL,
    this.description,
    this.showcaseUrl,
    required this.interests,
  });

  static User fromJson(Map json, String id){
    return User(
      id: id,
      locationX: json['locationX'], 
      locationY: json['locationY'], 
      name: json['name'], 
      surname: json['surname'],
      locationDesc: json['locationDesc'],
      avatarURL: json['avatarURL'],
      description: json['description'],
      showcaseUrl: json['showcaseUrl'],
      interests: json['interests'],
    );
  }

  String get fullName => '$name $surname';
}
