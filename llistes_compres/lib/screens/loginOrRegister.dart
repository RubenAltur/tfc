import 'package:flutter/material.dart';
import 'package:llistes_compres/screens/loginScreen.dart';
import 'package:llistes_compres/screens/registerScreen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Loginscreen(
        onTap: togglePages,
      );
    } else {
      return Registerscreen(
        onTap: togglePages,
      );
    }
  }
}
