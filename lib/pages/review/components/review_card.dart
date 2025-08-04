import 'package:flutter/material.dart';
import 'package:proxima/classes/models/review.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review, required this.user});

  final Review review;
  final User user;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy. HH:mm').format(review.date);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              children: [
                Icon(Icons.person_outline_rounded, size: 40),
                Text(user.fullName, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            Text(review.comment, style: Theme.of(context).textTheme.bodyLarge),
            Text(formattedDate, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
