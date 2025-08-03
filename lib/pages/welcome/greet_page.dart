import 'package:flutter/material.dart';

class WelcomeGreetPage extends StatelessWidget {
  const WelcomeGreetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Icon(
          Icons.waving_hand_rounded,
          size: 60,
        ),
        Text( 
          'Welcome to Proxima',
          style: TextStyle( 
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
