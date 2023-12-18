import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileRootScreen extends StatefulWidget {
  const ProfileRootScreen({super.key});

  @override
  State<ProfileRootScreen> createState() => _ProfileRootScreenState();
}

class _ProfileRootScreenState extends State<ProfileRootScreen> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.deepPurple,
      child: Center(
        child: FilledButton(
          onPressed: () {
            context.go('/profile/details');
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
