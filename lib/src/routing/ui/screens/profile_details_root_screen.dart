import 'package:flutter/material.dart';

class ProfileDetailsRootScreen extends StatefulWidget {
  const ProfileDetailsRootScreen({super.key});

  @override
  State<ProfileDetailsRootScreen> createState() =>
      _ProfileDetailsRootScreenState();
}

class _ProfileDetailsRootScreenState extends State<ProfileDetailsRootScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.deepPurpleAccent,
      child: Center(child: Text('Profile Details Screen')),
    );
  }
}
