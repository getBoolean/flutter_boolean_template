import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: const AutoLeadingButton(),
      ),
      backgroundColor: Colors.red,
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.pushRoute(const SettingsDetailsRoute());
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
