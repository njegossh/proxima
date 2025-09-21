import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import '../controller.dart';

class TagSuggestionsDialog extends StatelessWidget {
  final SearchMainController controller;

  const TagSuggestionsDialog({
    super.key,
    required this.controller,
  });

  static void show(BuildContext context, SearchMainController controller) {
    showDialog(
      context: context,
      builder: (context) => TagSuggestionsDialog(controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        final availableTags = controller.allAvailableTags
            .where((tag) => !controller.selectedTags.contains(tag))
            .toList();

        return AlertDialog(
          title: Text("Choose tags".tr),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: availableTags.isEmpty
                ? Center(
                    child: Text(
                      "All tags already selected!".tr,
                    ),
                  )
                : ListView.builder(
                    itemCount: availableTags.length,
                    itemBuilder: (context, index) {
                      final tag = availableTags[index];
                      return ListTile(
                        title: Text(tag),
                        trailing: const Icon(Icons.add),
                        onTap: () {
                          controller.addTag(tag);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close".tr),
            ),
          ],
        );
      },
    );
  }
}
