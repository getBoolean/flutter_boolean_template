import 'package:flutter/material.dart';
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
              context.go('/profile/details');
            },
            child: const Text('Push Details'),
          ),
        ),
      ),
    );
  }
}
