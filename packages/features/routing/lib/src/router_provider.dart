import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'ui/app_scaffold.dart';

part 'router_provider.g.dart';

// Source: https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter-beamer/

// Keep in mind that the navigation position of each page won't be preserved until StatefulShellRoute from
// https://github.com/flutter/packages/pull/2650 is merged

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
RouterConfig<Object> router(RouterRef ref) {
  final navigationRoutes = <RouteBase>[
    GoRoute(
      path: '/home',
      // `pageBuilder` is used so that a `NoTransitionPage` can be used
      // when switching tabs. If you want the default transition, use `builder`.
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Center(child: Text('Home')),
      ),
    ),
    GoRoute(
      path: '/search',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Center(child: Text('Search')),
      ),
    ),
    GoRoute(
      path: '/account',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Center(child: Text('Account')),
      ),
    ),
  ];

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: navigationRoutes,
      ),
    ],
  );
}
