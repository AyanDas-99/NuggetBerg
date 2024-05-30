import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.backgroundColor,
      required this.padding});
  final Widget child;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(padding),
            backgroundColor: MaterialStatePropertyAll(backgroundColor),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
