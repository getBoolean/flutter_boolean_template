import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.navigateTo(const ProfileDetailsRoute());
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
