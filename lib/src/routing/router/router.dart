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

enum RouteName {
  books,
  bookDetails,
  profile,
  profileDetails,
  settings,
  settingDetails;
}

final routerProvider = Provider<GoRouter>((ref) {
  final log = ref.watch(logProvider('routerProvider'));

  return createRouter(log: log);
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

GoRouter createRouter({required Logger log}) {
  return GoRouter(
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
            duration: const Duration(milliseconds: 300),
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
}

StatefulShellBranch _buildSettingsBranch(RouterDestination destination) {
  return StatefulShellBranch(
    observers: [
      AppObserver(),
    ],
    navigatorKey: destination.navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        name: RouteName.settings.name,
        // The screen to display as the root in the third tab of the
        // bottom navigation bar.
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) =>
            const SettingsRootScreen(
          key: ValueKey('SETTINGS'),
        ),
        routes: <RouteBase>[
          GoRoute(
            name: RouteName.settingDetails.name,
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
        name: RouteName.profile.name,
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) =>
            const ProfileRootScreen(
          key: ValueKey('PROFILE'),
        ),
        routes: <RouteBase>[
          GoRoute(
            name: RouteName.profileDetails.name,
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
        name: RouteName.books.name,
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
            name: RouteName.bookDetails.name,
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
    final routeName = topRoute?.name;
    if (routeName == null) return null;
    return switch (RouteName.values.byName(routeName)) {
      RouteName.books => 'Books',
      RouteName.bookDetails => 'Book ${pathParameters['id']}',
      RouteName.profile => 'Profile',
      RouteName.profileDetails => 'Profile Details',
      RouteName.settings => 'Settings',
      RouteName.settingDetails => 'Setting Details',
    };
  }
}
