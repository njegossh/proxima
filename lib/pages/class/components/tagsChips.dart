import 'package:flutter/material.dart';

class TagsChips extends StatelessWidget {
  final List<String>? listOfInterests;
  const TagsChips({super.key, this.listOfInterests});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            listOfInterests?.map((interest) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: Chip(
                  label: Text(interest, style: TextStyle(color: Colors.white, fontSize: 16),),
                  backgroundColor: Colors.indigo[400],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              );
            }).toList() ??
            [],
      ),
    );
  }
}
