import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/user/main_page.dart';
import 'controller.dart';

class FollowMainPage extends StatefulWidget {
  final String title;
  final String userId;
  final bool getFollowers;

  const FollowMainPage({
    super.key,
    required this.title,
    required this.userId,
    required this.getFollowers,
  });

  @override
  State<FollowMainPage> createState() => _FollowMainPageState();
}

class _FollowMainPageState extends State<FollowMainPage> {
  late final FollowController controller;

  @override
  void initState() {
    super.initState();
    controller = FollowController(
      userId: widget.userId,
      getFollowers: widget.getFollowers,
    );
    controller.updateUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          if (controller.users.isEmpty) {
            return Center(child: Text("No users yet".tr));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controller.userCount,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    leading: _buildUserAvatar(user),
                    title: Text(user.fullName),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserMainPage(user: user),
                        ),
                      );
                      controller.updateUsers();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildUserAvatar(User user) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: (user.imageString != null && user.imageString!.isNotEmpty)
            ? Image.memory(
                base64Decode(user.imageString!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 40),
              )
            : const Icon(Icons.person, size: 40),
      ),
    );
  }
}
