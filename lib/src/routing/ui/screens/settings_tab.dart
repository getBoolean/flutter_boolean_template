import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/settings_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const SettingsWidget();
  }
}
