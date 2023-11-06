import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/auto_app_bar.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/settings_widget.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AutoAppBar(),
      backgroundColor: Colors.red,
      body: SettingsWidget(),
    );
  }
}
