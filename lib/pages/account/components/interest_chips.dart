import 'package:flutter/material.dart';

class InterestChips extends StatelessWidget {
  final List<String>? listOfInterests;
  const InterestChips({super.key, this.listOfInterests});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            listOfInterests?.map((interest) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: Chip(
                  label: Text(interest),
                ),
              );
            }).toList() ??
            [],
      ),
    );
  }
}
