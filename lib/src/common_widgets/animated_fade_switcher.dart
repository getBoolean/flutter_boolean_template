import 'package:flutter/material.dart';

class AnimatedFadeSwitcher extends StatelessWidget {
  const AnimatedFadeSwitcher({
    super.key,
    required this.shouldSwitch,
    required this.child,
    required this.secondChild,
  });

  final bool Function() shouldSwitch;
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
      child: shouldSwitch() ? child : secondChild,
    );
  }
}
