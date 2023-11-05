import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';
import 'package:log/log.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: const [
        BooksRoute(),
        ProfileRoute(),
        SettingsRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return AdaptiveNavigationScaffold(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: (index) {
            if (tabsRouter.activeIndex == index) {
              tabsRouter.innerRouterOf(tabsRouter.current.name)?.popTop();
            }
            tabsRouter.setActiveIndex(index);
          },
          destinations: const [
            AdaptiveScaffoldDestination(title: 'Books', icon: Icons.book),
            AdaptiveScaffoldDestination(title: 'Profile', icon: Icons.person),
            AdaptiveScaffoldDestination(
              title: 'Settings',
              icon: Icons.settings,
            ),
          ],
          body: child,
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return LoggerWidget(child: this);
  }
}
