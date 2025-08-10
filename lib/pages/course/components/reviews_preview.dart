import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/classes/models/review.dart';
import 'package:proxima/pages/review/main_page.dart';

class ReviewsPreview extends StatelessWidget {
  final Course course;
  final List<Review> reviews;
  const ReviewsPreview({super.key, required this.reviews, required this.course,});

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
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: reviews.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color:Theme.of(context).colorScheme.secondary,),
                          Text("${review.value}"),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(review.comment, style: TextStyle(fontWeight: FontWeight.w100),),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 8,),
          OutlinedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ReviewMainPage(course: course);
            }));
          }, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.remove_red_eye_outlined),
              SizedBox(width: 8,),
              Text("Sve recenzije"),
            ],
          ))
        ],
      ),
    );
  }
}
