import 'package:flutter/material.dart';

import '../widgets/login_form.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const LoginForm(),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
      ),
    );
  }
}
