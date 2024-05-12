import 'package:flutter/material.dart';
import 'package:nugget_berg/view/auth/screens/login_screen.dart';
import 'package:nugget_berg/view/auth/screens/signup_screen.dart';

class AuthScreenController extends StatefulWidget {
  const AuthScreenController({super.key});

  @override
  State<AuthScreenController> createState() => _AuthScreenControllerState();
}

class _AuthScreenControllerState extends State<AuthScreenController> {
  bool signIn = true;

  switchSignInSignOut() {
    setState(() {
      signIn = !signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return signIn
        ? LoginScreen(
            swapWithSignup: switchSignInSignOut,
          )
        : SignUpScreen(
            swapToLogin: switchSignInSignOut,
          );
  }
}
