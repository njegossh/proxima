class CourseTagGroup {
  final String name;
  final List<String> items;

  CourseTagGroup({required this.name, required this.items});

  static CourseTagGroup fromJson(Map json) {
    return CourseTagGroup(
      name: json['name'] ?? '...',
      items: (json['items'] as List).map((i) => '$i').toList(),
    );
  }
}
