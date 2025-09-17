import 'dart:convert';
import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/review.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
    required this.user,
    required this.isCurrentUser,
  });

  final Review review;
  final User user;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy. HH:mm').format(review.date);

    return Card(
      shape: RoundedRectangleBorder(
        side: isCurrentUser
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    clipBehavior: Clip.antiAlias,
                    child: Image.memory(
                      base64Decode(user.imageString ?? ''),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.person, size: 45),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            EasyStarsDisplay(
              initialRating: review.value,
              allowHalfRating: true,
              readOnly: true,
              filledColor: Theme.of(context).colorScheme.secondary,
            ),
            Text(review.comment, style: Theme.of(context).textTheme.bodyLarge),
            Text(formattedDate, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
