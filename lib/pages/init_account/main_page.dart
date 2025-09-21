import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/init_account/controller.dart';
import 'components/avatar_section.dart';
import 'components/form_card.dart';

class InitAccountMainPage extends StatefulWidget {
  final bool isInitialized;
  const InitAccountMainPage({super.key, required this.isInitialized});

  @override
  State<InitAccountMainPage> createState() => _InitAccountMainPageState();
}

class _InitAccountMainPageState extends State<InitAccountMainPage> {
  late final InitAccountController controller;
  final _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await File(image.path).readAsBytes();
      final base64String = base64Encode(bytes);
      setState(() {
        controller.imageString = base64String;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller = InitAccountController(isInitialized: widget.isInitialized);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, index) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Set up your profile".tr,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 1,
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    AvatarSection(
                      imageString: controller.imageString,
                      onPickImage: _pickImage,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: FormCard(
                    controller: controller,
                    isInitialized: widget.isInitialized,
                    onActionPressed: () {
                      controller.updateAccount();
                      if (controller.isInitialized) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
