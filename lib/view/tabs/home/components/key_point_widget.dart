import 'package:flutter/material.dart';

class KeyPointWidget extends StatelessWidget {
  final String text;
  const KeyPointWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
      ),
    );
  }
}
