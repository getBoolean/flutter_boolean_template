import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/auto_app_bar.dart';

@RoutePage()
class SettingsDetailsScreen extends StatelessWidget {
  const SettingsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AutoAppBar(
        title: Text(context.topRoute.name),
      ),
      backgroundColor: Colors.redAccent,
      body: const Center(child: Text('Setting Option Screen')),
    );
  }
}
