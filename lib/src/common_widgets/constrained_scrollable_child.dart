import 'package:flutter/material.dart';

class ConstrainedScrollableChild extends StatelessWidget {
  const ConstrainedScrollableChild({
    super.key,
    required this.child,
    this.direction = Axis.vertical,
  });

  final Widget child;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: switch (direction) {
            Axis.vertical => BoxConstraints(minHeight: constraints.maxHeight),
            Axis.horizontal => BoxConstraints(minWidth: constraints.maxWidth),
          },
          child: IntrinsicHeight(
            child: child,
          ),
        ),
      ),
    );
  }
}
