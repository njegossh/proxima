import 'package:flutter/material.dart';

class TagsChips extends StatelessWidget {
  final List<String> interests;
  const TagsChips({super.key, required this.interests});

  @override
  Widget build(BuildContext context) {
    return ListView.builder( 
      scrollDirection: Axis.horizontal,
      itemCount: interests.length,
      itemBuilder: ( context, i ){
        return Padding( 
          padding: const EdgeInsets.all(2),
          child: Chip(label: Text(interests[i])),
        );
      },
    );
  }
}
