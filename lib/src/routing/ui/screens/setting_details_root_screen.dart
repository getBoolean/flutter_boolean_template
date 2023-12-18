import 'package:flutter/material.dart';

class SettingDetailsRootScreen extends StatefulWidget {
  const SettingDetailsRootScreen({super.key});

  @override
  State<SettingDetailsRootScreen> createState() =>
      _SettingDetailsRootScreenState();
}

class _SettingDetailsRootScreenState extends State<SettingDetailsRootScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.redAccent,
      child: Center(child: Text('Setting Option Screen')),
    );
  }
}
