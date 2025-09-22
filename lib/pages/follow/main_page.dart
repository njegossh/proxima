import 'package:flutter/material.dart';
import 'package:proxima/classes/models/user.dart';
import 'package:proxima/main.dart';
import 'package:proxima/pages/user/main_page.dart';
import 'controller.dart';

class FollowMainPage extends StatefulWidget {
  final String title;
  final List<User> users;

  const FollowMainPage({super.key, required this.title, required this.users});

  @override
  State<FollowMainPage> createState() => _FollowMainPageState();
}

class _FollowMainPageState extends State<FollowMainPage> {
  late final FollowController controller;

  @override
  void initState() {
    super.initState();
    controller = FollowController(users: widget.users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: controller.users.isEmpty
          ? Center(child: Text("No users yet".tr)) //TODO dodati u translation
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: controller.userCount,
              itemBuilder: (context, index) {
                final user = controller.users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, size: 24, color: Colors.white), //TODO RISTICU DODAJ SLIKU PLS NISAM STIGO MORAM ZA NIS ASAP
                    ),
                    title: Text(user.fullName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserMainPage(user: user); //TODO RISTICU AKO STIGNES STATE MANAGEMENT ZA OVO KAD UNFOLLOWUJEM NPR PA SE VRATIM DA GA NEMA
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
