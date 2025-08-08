import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';

class LocationInfo extends StatelessWidget {
  final User user;
  const LocationInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_pin_circle_outlined),
              Text(
                user.locationDesc != null
                    ? user.locationDesc!.join(", ")
                    : "Nema podataka za lokaciju.",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
