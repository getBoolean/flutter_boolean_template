import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_update_title_state_mixin.dart';

@RoutePage<String>()
class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen>
    with AutoUpdateTitleStateMixin<ProfileDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.deepPurpleAccent,
      child: Center(child: Text('Profile Details Screen')),
    );
  }
}
