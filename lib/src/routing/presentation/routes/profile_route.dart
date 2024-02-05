import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/profile/presentation/profile_screen.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}
