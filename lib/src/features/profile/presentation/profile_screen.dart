import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.deepPurple,
        child: Center(
          child: FilledButton(
            onPressed: () {
              context.goNamed(RouteName.profileDetails.name);
            },
            child: const Text('Push Details'),
          ),
        ),
      ),
    );
  }
}
