import 'package:flutter/material.dart';

class UnknownSettingsScreen extends StatelessWidget {
  const UnknownSettingsScreen({
    super.key,
    this.id,
  });

  final String? id;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.redAccent,
      child: Center(child: Text(' ${id ?? 'Unknown'}Setting')),
    );
  }
}
