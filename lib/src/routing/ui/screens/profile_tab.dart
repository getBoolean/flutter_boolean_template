import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.deepPurple,
      child: Center(
        child: FilledButton(
          onPressed: () {
            // goTo(const ProfileDetailsRoute());
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
