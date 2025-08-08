import 'package:flutter/material.dart';
import 'package:proxima/pages/review/components/review_card.dart';
import 'package:proxima/pages/review/controller.dart';
import 'package:proxima/pages/review/write_review_sheet.dart';

class ReviewMainPage extends StatefulWidget {
  const ReviewMainPage({
    super.key,
    required this.userId,
    required this.classId,
  });

  final String userId;
  final String classId;

  @override
  State<ReviewMainPage> createState() => _ReviewMainPageState();
}

class _ReviewMainPageState extends State<ReviewMainPage> {
  late final ReviewMainController controller;

  @override
  void initState() {
    super.initState();
    controller = ReviewMainController(
      userId: widget.userId,
      classId: widget.classId,
    );
    controller.init(); // make sure we actually fetch the data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
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
        label: const Text('Write a review'),
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
                    isCurrentUser: review.userID == widget.userId,
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
