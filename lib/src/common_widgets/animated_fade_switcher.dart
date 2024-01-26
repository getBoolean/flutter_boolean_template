import 'package:flutter/material.dart';

class AnimatedFadeSwitcher extends StatelessWidget {
  const AnimatedFadeSwitcher({
    required this.shouldSwitch,
    required this.child,
    required this.secondChild,
    super.key,
  });

  final bool shouldSwitch;
  final Widget child;
  final Widget secondChild;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: shouldSwitch ? child : secondChild,
    );
  }
}
