import 'package:flutter/material.dart';

class StartupLoading extends StatelessWidget {
  const StartupLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: CircularProgressIndicator(),),);
  }
}