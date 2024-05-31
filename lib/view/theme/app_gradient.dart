import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_gradient.g.dart';

@riverpod
class AppGradient extends _$AppGradient {
  @override
  LinearGradient build() {
    return const LinearGradient(
      colors: [
        Color.fromARGB(255, 206, 177, 181),
        Color(0xFFffdde1),
      ],
    );
  }

  void change(LinearGradient gradient) {
    state = gradient;
  }
}

@riverpod
List<LinearGradient> allAppGradients(AllAppGradientsRef ref) {
  return const [
    LinearGradient(
      colors: [
        Color.fromARGB(255, 206, 177, 181),
        Color(0xFFffdde1),
      ],
    ),
    LinearGradient(
      colors: [
        Color.fromARGB(255, 106, 173, 218),
        Color.fromARGB(255, 162, 228, 252),
        Color.fromRGBO(255, 255, 255, 1),
      ],
    ),
    LinearGradient(colors: [])
  ];
}
