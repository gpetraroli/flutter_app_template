import 'package:flutter/material.dart';

import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  static final routeName = '/sign-up';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const SignUpForm(),
      ),
    );
  }
}
