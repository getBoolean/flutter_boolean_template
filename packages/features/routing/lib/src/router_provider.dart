import 'package:flutter/material.dart';
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
  final navigationRoutes = <GoRoute>[
    GoRoute(
      name: 'home',
      path: '/home',
      // `pageBuilder` is used so that a `NoTransitionPage` can be used
      // when switching tabs. If you want the default transition, use `builder`.
      pageBuilder: (context, state) => NoTransitionPage(
        child: Center(
          child: TextButton(
            onPressed: () => context.pushNamed('homeDetails'),
            child: const Text('Home Details'),
          ),
        ),
      ),
      routes: [
        GoRoute(
          name: 'homeDetails',
          path: 'details',
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: const Center(child: Text('Home Details')),
          ),
        ),
      ],
    ),
    GoRoute(
      name: 'search',
      path: '/search',
      pageBuilder: (context, state) => NoTransitionPage(
        child: Center(
          child: TextButton(
            onPressed: () => context.pushNamed('searchDetails'),
            child: const Text('Search Details'),
          ),
        ),
      ),
      routes: [
        GoRoute(
          name: 'searchDetails',
          path: 'details',
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
            ),
            body: const Center(child: Text('Search Details')),
          ),
        ),
      ],
    ),
    GoRoute(
      name: 'account',
      path: '/account',
      pageBuilder: (context, state) => NoTransitionPage(
        child: Center(
          child: TextButton(
            onPressed: () => context.pushNamed('accountDetails'),
            child: const Text('Account Details'),
          ),
        ),
      ),
      routes: [
        GoRoute(
          name: 'accountDetails',
          path: 'details',
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: const Text('Account'),
            ),
            body: const Center(child: Text('Account Details')),
          ),
        ),
      ],
    ),
  ];

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: navigationRoutes.first.path,
    redirect: (context, state) {
      // If the current location is not found, redirect to the first tab
      if (state.location.isEmpty) {
        debugPrint('ERROR: INVALID LOCATION\n\n${StackTrace.current}\n');
        return navigationRoutes.first.path;
      }
      return null;
    },
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
