import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/widgets/settings_widget.dart';

class SettingsRootScreen extends StatefulWidget {
  const SettingsRootScreen({super.key});

  @override
  State<SettingsRootScreen> createState() => _SettingsRootScreenState();
}

class _SettingsRootScreenState extends State<SettingsRootScreen> {
  @override
  Widget build(BuildContext context) {
    return const SettingsWidget();
  }
}
