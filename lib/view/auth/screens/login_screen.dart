import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/%20repositories/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final VoidCallback swapWithSignup;
  const LoginScreen({super.key, required this.swapWithSignup});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                ref.read(authRepositoryNotifierProvider.notifier).googleLogin();
              },
              child: Text('Login with google')),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 8) {
                      return 'Password should be atleast 8 characters long';
                    }
                    return null;
                  },
                ),
                TextButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      ref
                          .read(authRepositoryNotifierProvider.notifier)
                          .emailLogin(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    },
                    child: Text('Log In')),
              ],
            ),
          ),
          TextButton(
              onPressed: widget.swapWithSignup,
              child: const Text('Create account')),
        ],
      ),
    );
  }
}
