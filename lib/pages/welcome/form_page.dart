import 'package:flutter/material.dart';
import 'controller.dart';

class WelcomeFormPage extends StatelessWidget {
  final WelcomeController controller;
  const WelcomeFormPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.login_rounded,
            size: 60,
          ),
          SizedBox(height: 50),
          TextField( 
            controller: controller.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration( 
              labelText: 'E-mail',
              errorText: controller.emailError,
              icon: Icon(Icons.email_rounded),
            ),
          ),
          SizedBox(height: 50),
          TextField( 
            controller: controller.password,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration( 
              labelText: 'Password',
              errorText: controller.passwordError,
              icon: Icon(Icons.password_rounded),
            ),
          ),
        ],
      ),
    );
  }

}
