import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nugget_berg/state/auth/%20repositories/auth_repository.dart';
import 'package:nugget_berg/state/auth/models/auth_result.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/auth/screens/forgot_password_screen.dart';
import 'package:nugget_berg/view/components/main_button.dart';

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

  googleSignIn() async {
    final navigator = Navigator.of(context);
    await ref.read(authRepositoryNotifierProvider.notifier).googleLogin();
    final loggedIn = ref.read(authRepositoryNotifierProvider
        .select((value) => value.authResult == AuthResult.success));
    if (loggedIn) {
      navigator.pop();
    }
  }

  goToForgotPasswordScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ForgotPasswordScreen(),
    ));
  }

  // forgotPassword() async {
  //   final navigator = Navigator.of(context);
  //   if (emailController.text.isEmpty) {
  //     ref
  //         .read(scaffoldMessengerProvider)
  //         .showSnackBar(const SnackBar(content: Text('Enter email')));
  //   }
  //   await ref
  //       .read(authRepositoryNotifierProvider.notifier)
  //       .forgotPassword(email: emailController.text);
  // }

  @override
  Widget build(BuildContext context) {
    final authLoading = ref.watch(
        authRepositoryNotifierProvider.select((value) => value.isLoading));
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        children: [
          Center(
              child: Text(
            login,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          )),
          const SizedBox(height: 20),
          Text(
            welcome,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
          ),
          const SizedBox(height: 10),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: emailAd,
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: password,
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
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
                // const SizedBox(height: 10),
                TextButton(
                    onPressed: goToForgotPasswordScreen,
                    child: Text(
                      forgot,
                      style: TextStyle(
                          color: Colors.blue.shade600,
                          decoration: TextDecoration.underline),
                    )),
                MainButton(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    onPressed: () {},
                    backgroundColor: Colors.blue,
                    child: Text(
                      login,
                      style: const TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
              child: Text(
            or,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          )),
          const SizedBox(height: 20),
          if (!authLoading)
            MainButton(
              onPressed: googleSignIn,
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    googleSign,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          if (authLoading)
            MainButton(
              onPressed: () {},
              backgroundColor: Colors.blueAccent.shade100,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: const CircularProgressIndicator(color: Colors.white),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(newUser),
              TextButton(
                  onPressed: widget.swapWithSignup,
                  child: Text(
                    signUp,
                    style:
                        const TextStyle(decoration: TextDecoration.underline),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
