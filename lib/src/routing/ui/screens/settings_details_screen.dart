import 'package:flutter/material.dart';

class SettingsDetailsScreen extends StatefulWidget {
  const SettingsDetailsScreen({super.key});

  @override
  State<SettingsDetailsScreen> createState() => _SettingsDetailsScreenState();
}

class _SettingsDetailsScreenState extends State<SettingsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.redAccent,
      child: Center(child: Text('Setting Option Screen')),
    );
  }
}
