import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.deepPurpleAccent,
      child: Center(child: Text('Profile Details Screen')),
    );
  }
}
