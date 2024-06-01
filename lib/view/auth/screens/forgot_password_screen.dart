import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nugget_berg/state/auth/%20repositories/auth_repository.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/components/main_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void sendResetLink() async {
    if (!formkey.currentState!.validate()) return;
    await ref
        .read(authRepositoryNotifierProvider.notifier)
        .forgotPassword(email: emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    final authLoading = ref.watch(
        authRepositoryNotifierProvider.select((value) => value.isLoading));
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              forgot,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              enterTheEmailUsed,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Form(
              key: formkey,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: emailAd,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
            ),
            const SizedBox(height: 20),
            if (authLoading)
              MainButton(
                onPressed: () {},
                backgroundColor: Colors.blueAccent.shade100,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const CircularProgressIndicator(color: Colors.white),
              ),
            if (!authLoading)
              MainButton(
                padding: const EdgeInsets.symmetric(vertical: 20),
                onPressed: sendResetLink,
                backgroundColor: Colors.blue,
                child: Text(
                  sendReset,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
