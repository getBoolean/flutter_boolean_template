import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_update_title_state_mixin.dart';

@RoutePage<String>()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutoUpdateTitleStateMixin<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.pinkAccent,
      child: Center(
        child: FilledButton(
          onPressed: () {
            goTo(const ProfileDetailsRoute());
          },
          child: const Text('Push Details'),
        ),
      ),
    );
  }
}
