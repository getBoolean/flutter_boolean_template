import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/screens/about_settings_screen.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/screens/appearance_settings_screen.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/screens/unknown_settings_screen.dart';

class SettingDetailsRoute extends StatefulWidget {
  const SettingDetailsRoute({super.key, this.id});

  final String? id;

  @override
  State<SettingDetailsRoute> createState() => _SettingDetailsRouteState();
}

class _SettingDetailsRouteState extends State<SettingDetailsRoute> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.id) {
      'about' => const AboutSettingsScreen(),
      'appearance' => const AppearanceSettingsScreen(),
      _ => UnknownSettingsScreen(id: widget.id)
    };
  }
}
