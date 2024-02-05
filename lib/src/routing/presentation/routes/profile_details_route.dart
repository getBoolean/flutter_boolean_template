import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/profile/presentation/profile_details_screen.dart';

class ProfileDetailsRoute extends StatefulWidget {
  const ProfileDetailsRoute({super.key});

  @override
  State<ProfileDetailsRoute> createState() => _ProfileDetailsRouteState();
}

class _ProfileDetailsRouteState extends State<ProfileDetailsRoute> {
  @override
  Widget build(BuildContext context) {
    return const ProfileDetailsScreen();
  }
}
