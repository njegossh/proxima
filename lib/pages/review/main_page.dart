import 'package:flutter/material.dart';
import 'package:proxima/classes/models/course.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/review/components/review_card.dart';
import 'package:proxima/pages/review/controller.dart';
import 'package:proxima/pages/review/write_review_sheet.dart';

class ReviewMainPage extends StatefulWidget {
  final Course course;
  const ReviewMainPage({
    super.key,
    required this.course,
  });

  @override
  State<ReviewMainPage> createState() => _ReviewMainPageState();
}

class _ReviewMainPageState extends State<ReviewMainPage> {
  late final ReviewMainController controller;

  @override
  void initState() {
    super.initState();
    controller = ReviewMainController(course: widget.course);
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reviews".tr)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            builder: (context) => WriteReviewSheet(controller: controller),
          );

          if (result != null) {
            await controller.reviewWrite(result);
          }
        },
        icon: const Icon(Icons.edit),
        label: Text("Make a review".tr),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final reviewsList = controller.reviewsList;
          final userMap = controller.reviewsMap;

          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 150),
            itemCount: reviewsList.length,
            itemBuilder: (context, index) {
              final review = reviewsList[index];
              final user = userMap[review.userID];
              if (user == null) {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  ReviewCard(
                    review: review,
                    user: user,
                    isCurrentUser: review.userID == currentUser.id,
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        },
      ),
    );
  }
}
