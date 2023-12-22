import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/ui.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/implicitly_animated_page_switcher.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log/log.dart';

export 'router_extensions.dart';

// Source: https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter-beamer/

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorBooksKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellBooks');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProfile');
final _shellNavigatorSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

const kBooksRouteName = 'books';
const kBookDetailsRouteName = 'bookDetails';
const kProfileRouteName = 'profile';
const kProfileDetailsRouteName = 'profileDetails';
const kSettingsRouteName = 'settings';
const kSettingDetailsRouteName = 'settingDetails';

final routerProvider = Provider<GoRouter>((ref) {
  final _ = ref.watch(logProvider('routerProvider'));

  return router;
});

final destinations = [
  RouterDestination(
    title: 'Books',
    icon: Icons.book,
    navigatorKey: _shellNavigatorBooksKey,
  ),
  RouterDestination(
    title: 'Profile',
    icon: Icons.person,
    navigatorKey: _shellNavigatorProfileKey,
  ),
  RouterDestination(
    title: 'Settings',
    icon: Icons.settings,
    navigatorKey: _shellNavigatorSettingsKey,
  ),
];

final router = GoRouter(
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: rootNavigatorKey,
  initialLocation: '/books',
  observers: [
    AppObserver(),
  ],
  routes: <RouteBase>[
    StatefulShellRoute(
      parentNavigatorKey: rootNavigatorKey,
      navigatorContainerBuilder: (
        BuildContext context,
        StatefulNavigationShell navigationShell,
        List<Widget> children,
      ) {
        return ImplicitlyAnimatedPageSwitcher(
          currentIndex: navigationShell.currentIndex,
          duration: const Duration(milliseconds: 150),
          animatePageTransition: true,
          children: children,
        );
      },
      builder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return RootScaffoldShell(
          navigationShell: navigationShell,
          destinations: destinations,
          title: state.titleBuilder(context) ?? 'No Title',
        );
      },
      branches: <StatefulShellBranch>[
        _buildBooksBranch(destinations[0]),
        _buildProfileBranch(destinations[1]),
        _buildSettingsBranch(destinations[2]),
      ],
    ),
  ],
);

StatefulShellBranch _buildSettingsBranch(RouterDestination destination) {
  return StatefulShellBranch(
    observers: [
      AppObserver(),
    ],
    navigatorKey: destination.navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        name: kSettingsRouteName,
        // The screen to display as the root in the third tab of the
        // bottom navigation bar.
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) =>
            const SettingsRootScreen(
          key: ValueKey('SETTINGS'),
        ),
        routes: <RouteBase>[
          GoRoute(
            name: kSettingDetailsRouteName,
            path: 'details',
            builder: (BuildContext context, GoRouterState state) =>
                const SettingDetailsRootScreen(),
          ),
        ],
      ),
    ],
  );
}

StatefulShellBranch _buildProfileBranch(RouterDestination destination) {
  return StatefulShellBranch(
    observers: [
      AppObserver(),
    ],
    navigatorKey: destination.navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        name: kProfileRouteName,
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) =>
            const ProfileRootScreen(
          key: ValueKey('PROFILE'),
        ),
        routes: <RouteBase>[
          GoRoute(
            name: kProfileDetailsRouteName,
            path: 'details',
            builder: (BuildContext context, GoRouterState state) =>
                const ProfileDetailsRootScreen(),
          ),
        ],
      ),
    ],
  );
}

StatefulShellBranch _buildBooksBranch(RouterDestination destination) {
  return StatefulShellBranch(
    navigatorKey: destination.navigatorKey,
    observers: [
      AppObserver(),
    ],
    routes: <RouteBase>[
      GoRoute(
        name: kBooksRouteName,
        path: '/books',
        builder: (BuildContext context, GoRouterState state) {
          // only root routes should use query parameters because
          // popping a route will not change the query parameters to the previous route's
          final id = state.uri.queryParameters['id'];
          return BooksRootScreen(
            id: id,
            key: const ValueKey('BOOKS'),
          );
        },
        redirect: (BuildContext context, GoRouterState state) {
          // Transforming path params to query params because query params are shared and not cleared on pop
          final queryParamId = state.uri.queryParameters['id'];
          final pathParamId = state.pathParameters['id'];
          final deviceForm = $deviceForm(context);
          final numPages = state.uri.pathSegments.length;
          return switch ((numPages, deviceForm.isSmall)) {
            (1, true) when queryParamId != null =>
              '/books/details-$queryParamId',
            (2, false) =>
              pathParamId == null ? '/books' : '/books?id=$pathParamId',
            (_, _) => null,
          };
        },
        routes: <RouteBase>[
          GoRoute(
            name: kBookDetailsRouteName,
            path: 'details-:id',
            builder: (BuildContext context, GoRouterState state) {
              final id = state.pathParameters['id'];
              return BookDetailsRootScreen(id: id);
            },
          ),
        ],
      ),
    ],
  );
}

extension GoRouterStateTitleBuilder on GoRouterState {
  String? titleBuilder(BuildContext context) {
    switch (topRoute?.name) {
      case kBooksRouteName:
        return 'Books';
      case kBookDetailsRouteName:
        final id = pathParameters['id'];
        return 'Book $id';
      case kProfileRouteName:
        return 'Profile';
      case kProfileDetailsRouteName:
        return 'Profile Details';
      case kSettingsRouteName:
        return 'Settings';
      case kSettingDetailsRouteName:
        return 'Setting Details';
    }
    return null;
  }
}
