import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/ui.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
const kProfileRouteName = 'profile';
const kSettingsRouteName = 'settings';

final routerProvider = Provider<GoRouter>((ref) {
  final _ = ref.watch(logProvider('routerProvider'));

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
      _buildStatefulShellRoutePageView(
        parentNavigatorKey: rootNavigatorKey,
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          // Calculating the title using the path since the title needs to be
          // used by [ResponsiveScaffold]
          // This might be able to be improved if using go_router_builder
          final String title = switch (state.fullPath) {
            '/books' => state.uri.queryParameters['id'] == null
                ? 'Books'
                : 'Book ${state.uri.queryParameters['id']}',
            '/books/details-:id' => state.pathParameters['id'] == null
                ? 'Book Details'
                : 'Book ${state.pathParameters['id']}',
            '/profile' => 'Profile',
            '/profile/details' => 'Profile Details',
            '/settings' => 'Settings',
            '/settings/details' => 'Setting Details',
            _ => 'Unknown',
          };
          return RootScaffoldShell(
            navigationShell: navigationShell,
            destinations: destinations,
            title: title,
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
});

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
            name: 'Book Details',
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

class _PageViewRouteBranchContainer extends StatefulHookWidget {
  const _PageViewRouteBranchContainer({
    required this.currentIndex,
    required this.children,
  });

  final int currentIndex;

  final List<Widget> children;
  @override
  State<_PageViewRouteBranchContainer> createState() =>
      _PageViewRouteBranchContainerState();
}

class _PageViewRouteBranchContainerState
    extends State<_PageViewRouteBranchContainer>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pageItems = widget.children
        .mapIndexed((int index, Widget child) => _buildRouteBranchContainer(
            context, widget.currentIndex == index, child))
        .toList();
    return IndexedStack(
      index: widget.currentIndex,
      key: const ValueKey('rootRoutes'),
      children: pageItems,
    );
  }

  Widget _buildRouteBranchContainer(
      BuildContext context, bool isActive, Widget child) {
    return Offstage(
      offstage: !isActive,
      child: TickerMode(
        enabled: isActive,
        child: child,
      ),
    );
  }
}

Widget _pageViewContainerBuilder(
  BuildContext context,
  StatefulNavigationShell navigationShell,
  List<Widget> children,
) {
  return _PageViewRouteBranchContainer(
    currentIndex: navigationShell.currentIndex,
    children: children,
  );
}

StatefulShellRoute _buildStatefulShellRoutePageView({
  required List<StatefulShellBranch> branches,
  StatefulShellRouteBuilder? builder,
  GlobalKey<NavigatorState>? parentNavigatorKey,
  StatefulShellRoutePageBuilder? pageBuilder,
  String? restorationScopeId,
}) =>
    StatefulShellRoute(
      branches: branches,
      builder: builder,
      pageBuilder: pageBuilder,
      parentNavigatorKey: parentNavigatorKey,
      restorationScopeId: restorationScopeId,
      navigatorContainerBuilder: _pageViewContainerBuilder,
    );
