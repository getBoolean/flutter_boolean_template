// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BookDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BookDetailsScreen(),
      );
    },
    BooksRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BooksScreen(),
      );
    },
    BooksTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BooksTabPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const HomeScreen()),
      );
    },
    ProfileDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileDetailsScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    ProfileTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileTabPage(),
      );
    },
    SettingsDetailsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsDetailsScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    SettingsTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsTabPage(),
      );
    },
  };
}

/// generated route for
/// [BookDetailsScreen]
class BookDetailsRoute extends PageRouteInfo<void> {
  const BookDetailsRoute({List<PageRouteInfo>? children})
      : super(
          BookDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BookDetailsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BooksScreen]
class BooksRoute extends PageRouteInfo<void> {
  const BooksRoute({List<PageRouteInfo>? children})
      : super(
          BooksRoute.name,
          initialChildren: children,
        );

  static const String name = 'BooksRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BooksTabPage]
class BooksTab extends PageRouteInfo<void> {
  const BooksTab({List<PageRouteInfo>? children})
      : super(
          BooksTab.name,
          initialChildren: children,
        );

  static const String name = 'BooksTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileDetailsScreen]
class ProfileDetailsRoute extends PageRouteInfo<void> {
  const ProfileDetailsRoute({List<PageRouteInfo>? children})
      : super(
          ProfileDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileDetailsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileTabPage]
class ProfileTab extends PageRouteInfo<void> {
  const ProfileTab({List<PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsDetailsScreen]
class SettingsDetailsRoute extends PageRouteInfo<void> {
  const SettingsDetailsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsDetailsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsTabPage]
class SettingsTab extends PageRouteInfo<void> {
  const SettingsTab({List<PageRouteInfo>? children})
      : super(
          SettingsTab.name,
          initialChildren: children,
        );

  static const String name = 'SettingsTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}
