import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/%20repositories/auth_repository.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  final VoidCallback swapToLogin;
  const SignUpScreen({super.key, required this.swapToLogin});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
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
              child: const Text('Login with google')),
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
                          .createAccountWithEmail(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    },
                    child: const Text('Sign up')),
              ],
            ),
          ),
          TextButton(
              onPressed: widget.swapToLogin,
              child: const Text('Already have an account')),
        ],
      ),
    );
  }
}
