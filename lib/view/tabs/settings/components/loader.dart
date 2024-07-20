import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  final bool loading;

  const Loader({super.key, required this.loading});

  @override
  LoaderState createState() => LoaderState();
}

class LoaderState extends State<Loader> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    set();
  }

  void set() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animation = Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastEaseInToSlowEaseOut));

    if (widget.loading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant Loader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading && !oldWidget.loading) {
      _controller.forward();
    } else if (!widget.loading && oldWidget.loading) {
      _controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));

      _animation = Tween<double>(begin: 0.5, end: 1.0)
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

      _controller.forward();

      _animation.addListener(() {
        if (_animation.value == 1.0) {
          set();
          _controller.reset();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size.fromHeight(10)),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double opacity;
          if (_animation.value <= 0.5) {
            opacity = _animation.value * 2;
          } else {
            opacity = (1 - _animation.value) * 2;
          }
          return Opacity(
            opacity: opacity,
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              value: _animation.value,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}
