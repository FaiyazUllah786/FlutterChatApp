import 'package:flutter/material.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submitAuthForm({
    required String email,
    required String username,
    required String password,
    required bool isLogin,
  }) {
    print(email);
    print(password);
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 222, 222, 222),
      body: AuthForm(submitHelper: _submitAuthForm),
    );
  }
}
