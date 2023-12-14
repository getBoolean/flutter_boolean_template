import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log/log.dart';

// Source: https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter-beamer/

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorBooksKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellBooks');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
final _shellNavigatorSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

const kBooksRouteName = 'books';
const kProfileRouteName = 'profile';
const kSettingsRouteName = 'settings';

// Keep in mind that the navigation position of each page won't be preserved until StatefulShellRoute from
// https://github.com/flutter/packages/pull/2650 is merged
final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  final _ = ref.watch(logProvider('routerProvider'));

  final destinations = [
    RouterDestination(
      title: 'Books',
      icon: Icons.book,
      routeName: kBooksRouteName,
      navigatorKey: _shellNavigatorBooksKey,
    ),
    RouterDestination(
      title: 'Profile',
      icon: Icons.person,
      routeName: kProfileRouteName,
      navigatorKey: _shellNavigatorProfileKey,
    ),
    RouterDestination(
      title: 'Settings',
      icon: Icons.settings,
      routeName: kSettingsRouteName,
      navigatorKey: _shellNavigatorSettingsKey,
    ),
  ];

  return GoRouter(
    // * Passing a navigatorKey causes an issue on hot reload:
    // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
    // * However it's still necessary otherwise the navigator pops back to
    // * root on hot reload
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/books/details',
    debugLogDiagnostics: true,
    observers: [
      AppObserver(),
    ],
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.
          return RootScaffoldShell(
            navigationShell: navigationShell,
            destinations: destinations,
          );
        },
        branches: <StatefulShellBranch>[
          // The route branch for the first tab of the bottom navigation bar.
          _buildBooksBranch(destinations[0]),

          // The route branch for the second tab of the bottom navigation bar.
          _buildProfileBranch(destinations[1]),

          // The route branch for the third tab of the bottom navigation bar.
          _buildSettingsBranch(destinations[2]),
        ],
      ),
    ],
  );
});

StatefulShellBranch _buildSettingsBranch(RouterDestination destination) {
  return StatefulShellBranch(
    navigatorKey: destination.navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        name: destination.routeName,
        // The screen to display as the root in the third tab of the
        // bottom navigation bar.
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) =>
            const SettingsScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) =>
                const SettingsDetailsScreen(),
          ),
        ],
      ),
    ],
  );
}

StatefulShellBranch _buildProfileBranch(RouterDestination destination) {
  return StatefulShellBranch(
    navigatorKey: destination.navigatorKey,
    // It's not necessary to provide a navigatorKey if it isn't also
    // needed elsewhere. If not provided, a default key will be used.
    routes: <RouteBase>[
      GoRoute(
        name: destination.routeName,
        // The screen to display as the root in the second tab of the
        // bottom navigation bar.
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) =>
            const ProfileScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) =>
                const ProfileDetailsScreen(),
          ),
        ],
      ),
    ],
  );
}

StatefulShellBranch _buildBooksBranch(RouterDestination destination) {
  return StatefulShellBranch(
    navigatorKey: destination.navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        name: destination.routeName,
        // The screen to display as the root in the first tab of the
        // bottom navigation bar.
        // TODO: Include the book id in the path
        path: '/books',
        builder: (BuildContext context, GoRouterState state) =>
            const BooksScreen(),
        routes: <RouteBase>[
          // The details screen to display stacked on navigator of the
          // first tab. This will cover screen A but not the application
          // shell (bottom navigation bar).
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) =>
                const BookDetailsScreen(),
            redirect: (BuildContext context, GoRouterState state) {
              // final (_, deviceForm, _) = getDeviceDetails(context);
              // if (deviceForm case DeviceForm.phone || DeviceForm.largePhone) {
              //   // TODO: Include the book id in the path
              //   return context.namedLocation(kBooksRouteName);
              // }
              return null;
            },
          ),
        ],
      ),
    ],
  );
}
