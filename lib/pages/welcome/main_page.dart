import 'package:flutter/material.dart';
import 'controller.dart';
import 'form_page.dart';
import 'greet_page.dart';

class WelcomeMainPage extends StatefulWidget {
  const WelcomeMainPage({super.key});

  @override
  State<WelcomeMainPage> createState() => _WelcomeMainPageState();
}

class _WelcomeMainPageState extends State<WelcomeMainPage> {
  final controller = WelcomeController();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final error = await controller.actionClick();
              if( error != null){
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error)),
                );
              }
            },
            icon: Icon(Icons.chevron_right_rounded),
            label: Text(controller.actionName),
          ),
          body: PageView( 
            controller: controller.pageController,
            children: [
              WelcomeGreetPage(),
              WelcomeFormPage(controller: controller),
            ],
          ),
        );
      }
    );
  }
}
