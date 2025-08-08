import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/review.dart';
import 'package:proxima/pages/review/controller.dart';

class WriteReviewSheet extends StatefulWidget {
  const WriteReviewSheet({super.key, required this.controller});

  final ReviewMainController controller;

  @override
  State<WriteReviewSheet> createState() => _WriteReviewSheetState();
}

class _WriteReviewSheetState extends State<WriteReviewSheet> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  double _rating = 2.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Napiši recenziju',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EasyStarsRating(
                      initialRating: _rating,
                      animationConfig: StarAnimationConfig.pulse,
                      sizeVariant: StarSizeVariant.huge,
                      allowHalfRating: true,
                      filledColor: Theme.of(context).colorScheme.primary,
                      onRatingChanged: (value) {
                        setState(() {
                          _rating = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: 'Tvoj komentar',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: widget.controller.validateForm,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Zatvori'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(
                            context,
                            Review(
                              userID: widget.controller.userId,
                              classID: widget.controller.classId,
                              value: _rating,
                              comment: _commentController.text.trim(),
                              date: DateTime.now(),
                            ),
                          );
                        }
                      },
                      child: const Text('Pošalji'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
