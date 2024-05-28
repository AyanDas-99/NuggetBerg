import 'package:flutter/material.dart';
import 'package:nugget_berg/view/auth/screens/login_screen.dart';
import 'package:nugget_berg/view/auth/screens/signup_screen.dart';

class AuthScreenController extends StatefulWidget {
  const AuthScreenController({super.key, required this.signIn});
  final bool signIn;

  @override
  State<AuthScreenController> createState() => _AuthScreenControllerState();
}

class _AuthScreenControllerState extends State<AuthScreenController> {
  late bool signIn;

  switchSignInSignOut() {
    setState(() {
      signIn = !signIn;
    });
  }

  @override
  void initState() {
    signIn = widget.signIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return signIn
        ? LoginScreen(
            swapWithSignup: switchSignInSignOut,
          )
        : SignupScreen(
            swapWithLogin: switchSignInSignOut,
          );
  }
}
