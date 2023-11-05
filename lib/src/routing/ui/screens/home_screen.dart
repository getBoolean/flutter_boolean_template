import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/auto_adaptive_router_scaffold.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';
import 'package:log/log.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoAdaptiveRouterScaffold(
      drawerFooter: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Add'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      destinations: const [
        RouterDestination(
          title: 'Books',
          icon: Icons.book,
          route: BooksRoute(),
        ),
        RouterDestination(
          title: 'Profile',
          icon: Icons.person,
          route: ProfileRoute(),
        ),
        RouterDestination(
          title: 'Settings',
          icon: Icons.settings,
          route: SettingsRoute(),
        ),
      ],
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return LoggerWidget(child: this);
  }
}
