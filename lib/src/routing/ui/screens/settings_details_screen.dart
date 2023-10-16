import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsDetailsScreen extends StatelessWidget {
  const SettingsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.topRoute.name),
        leading: const AutoLeadingButton(),
      ),
      backgroundColor: Colors.redAccent,
      body: const Center(child: Text('Setting Option Screen')),
    );
  }
}
