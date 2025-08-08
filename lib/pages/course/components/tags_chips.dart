import 'package:flutter/material.dart';

class TagsChips extends StatelessWidget {
  final List<String> tags;
  const TagsChips({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 16, right: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            tags.map((interest) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: Chip(
                  label: Text(interest),
                ),
              );
            }).toList(),
      ),
    );
  }
}
