import 'package:flutter/material.dart';
import 'package:proxima/classes/models/review.dart';

class ReviewsPreview extends StatelessWidget {
  final List<Review> reviews;
  const ReviewsPreview({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.reviews_outlined),
              SizedBox(width: 8),
              Text(
                "Recenzije",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
