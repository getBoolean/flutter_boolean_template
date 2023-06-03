import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.topRoute.name),
        leading: const AutoLeadingButton(),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: const Center(child: Text('Profile Details Screen')),
    );
  }
}
