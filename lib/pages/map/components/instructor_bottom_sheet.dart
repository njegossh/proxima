import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';

class InstructorsBottomSheet extends StatelessWidget {
  const InstructorsBottomSheet({super.key, required this.instructors});

  final List<User> instructors;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .7,
      maxChildSize: 1,
      minChildSize: .2,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.all(16.0),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Available instructors".tr,
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
      },
    );
  }
}
