import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/settings_widget.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_update_title_state_mixin.dart';

@RoutePage<String>()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutoUpdateTitleStateMixin<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.red,
      child: SettingsWidget(),
    );
  }
}
