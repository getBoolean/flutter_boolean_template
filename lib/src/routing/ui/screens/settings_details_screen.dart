import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_update_title_state_mixin.dart';

@RoutePage()
class SettingsDetailsScreen extends StatefulWidget {
  const SettingsDetailsScreen({super.key});

  @override
  State<SettingsDetailsScreen> createState() => _SettingsDetailsScreenState();
}

class _SettingsDetailsScreenState extends State<SettingsDetailsScreen>
    with AutoUpdateTitleStateMixin<SettingsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(child: Text('Setting Option Screen')),
    );
  }
}
