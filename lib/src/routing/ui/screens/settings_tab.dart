import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/auto_adaptive_router_scaffold.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AutoAppBar(),
      backgroundColor: Colors.red,
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.navigateTo(const SettingsDetailsRoute());
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
