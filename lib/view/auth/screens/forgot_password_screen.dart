import 'package:flutter/material.dart';
import 'package:nugget_berg/view/all_strings.dart';
import 'package:nugget_berg/view/components/main_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  void sendResetLink() async {}

  @override
  Widget build(BuildContext context) {
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
            TextFormField(
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
            const SizedBox(height: 20),
            MainButton(
                padding: const EdgeInsets.symmetric(vertical: 20),
                onPressed: sendResetLink,
                backgroundColor: Colors.blue,
                child: Text(
                  sendReset,
                  style: const TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
