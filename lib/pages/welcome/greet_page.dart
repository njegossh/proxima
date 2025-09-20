import 'package:flutter/material.dart';

class WelcomeGreetPage extends StatelessWidget {
  const WelcomeGreetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Center(
          child: Image.asset(
            "assets/animations/logoAnimated.gif",
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Text('Welcome to Proxima', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
