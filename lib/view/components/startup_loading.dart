import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StartupLoading extends StatefulWidget {
  const StartupLoading({super.key});

  @override
  State<StartupLoading> createState() => _StartupLoadingState();
}

class _StartupLoadingState extends State<StartupLoading>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Image.asset(
          "assets/logos/logo_transparent.png",
          width: 200,
        )
            .animate(
              onPlay: (controller) => controller.repeat(reverse: true),
            )
            .slideX(duration: 1.seconds, begin: -0.3, end: 0.3, curve: Curves.easeInOut)
            .animate(
              delay: 500.milliseconds,
              onPlay: (controller) => controller.repeat(reverse: true),
            )
            .scale(
              duration: 1.seconds,
              begin: const Offset(0.7, 0.7),
              end: const Offset(1, 1),
              curve: Curves.easeInOut,
            ),
      ),
    );
  }
}
