import 'package:flutter/cupertino.dart';

class Profile {
  final String title;
  final String image;
  final Gradient gradient;

  Profile({required this.title, required this.image, required this.gradient});

  @override
  bool operator ==(covariant Profile other) => title == other.title;
}
