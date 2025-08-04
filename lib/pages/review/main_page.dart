import 'package:flutter/material.dart';
import 'package:proxima/pages/review/components/review_card.dart';
import 'package:proxima/pages/review/controller.dart';

class ReviewMainPage extends StatefulWidget {
  const ReviewMainPage({super.key});

  @override
  State<ReviewMainPage> createState() => _ReviewMainPageState();
}

class _ReviewMainPageState extends State<ReviewMainPage> {
  final controller = ReviewMainController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    controller.init().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final reviewsList = controller.reviewsList;
    final userMap = controller.reviewsMap;

    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.edit),
        label: Text('Write a review'),
      ),
      body: ListView.builder(
        itemCount: reviewsList.length,
        itemBuilder: (context, index) {
          final review = reviewsList[index];
          final user = userMap[review.userID];
          if (user == null) {
            return const SizedBox.shrink();
          }

          return ReviewCard(review: review, user: user);
        },
      ),
    );
  }
}
