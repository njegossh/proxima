import 'package:flutter/material.dart';
import 'package:proxima/main.dart';
import 'controller.dart';

class WelcomeFormPage extends StatelessWidget {
  final WelcomeController controller;
  const WelcomeFormPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.login_rounded,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),

          TextField(
            controller: controller.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'E-mail',
              errorText: controller.emailError,
              prefixIcon: Icon(Icons.email_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          TextField(
            controller: controller.password,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: 'Password'.tr,
              errorText: controller.passwordError,
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
