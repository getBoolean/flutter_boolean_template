import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_app_bar.dart';

@RoutePage()
class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AutoAppBar(
        title: Text(context.topRoute.name),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: const Center(child: Text('Profile Details Screen')),
    );
  }
}