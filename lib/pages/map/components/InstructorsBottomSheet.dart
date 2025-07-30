import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';

class InstructorsBottomSheet extends StatelessWidget {
  const InstructorsBottomSheet({super.key, required this.instructors});

  final List<User> instructors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Instructors',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: instructors.length,
              itemBuilder: (_, index) {
                final instructor = instructors[index];
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(instructor.fullName),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
