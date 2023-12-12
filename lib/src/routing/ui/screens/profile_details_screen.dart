import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.deepPurpleAccent,
      child: Center(child: Text('Profile Details Screen')),
    );
  }
}
