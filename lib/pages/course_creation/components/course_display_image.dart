import 'package:flutter/material.dart';

class CourseDisplayimage extends StatelessWidget {
  final String? displayImageURL;
  const CourseDisplayimage({super.key, this.displayImageURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: 200,
          child: Image.network(
            displayImageURL ?? '',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _){
              return SizedBox(
                width: double.infinity,
                child: Icon(
                  Icons.image_rounded,
                  size: 100,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
