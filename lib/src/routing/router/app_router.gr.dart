// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:flutter_boolean_template/src/routing/router/app_router.dart'
    as _i3;
import 'package:flutter_boolean_template/src/routing/ui/screens/book_details_screen.dart'
    as _i1;
import 'package:flutter_boolean_template/src/routing/ui/screens/books_tab.dart'
    as _i2;
import 'package:flutter_boolean_template/src/routing/ui/screens/home_screen.dart'
    as _i4;
import 'package:flutter_boolean_template/src/routing/ui/screens/profile_details_screen.dart'
    as _i5;
import 'package:flutter_boolean_template/src/routing/ui/screens/profile_tab.dart'
    as _i6;
import 'package:flutter_boolean_template/src/routing/ui/screens/settings_details_screen.dart'
    as _i7;
import 'package:flutter_boolean_template/src/routing/ui/screens/settings_tab.dart'
    as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    BookDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BookDetailsRouteArgs>(
          orElse: () => BookDetailsRouteArgs(
                  id: pathParams.getInt(
                'id',
                -1,
              )));
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BookDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    BooksRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BooksScreen(),
      );
    },
    BooksTab.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.BooksTabPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.WrappedRoute(child: const _i4.HomeScreen()),
      );
    },
    ProfileDetailsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ProfileDetailsScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ProfileScreen(),
      );
    },
    ProfileTab.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ProfileTabPage(),
      );
    },
    SettingsDetailsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsDetailsScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SettingsScreen(),
      );
    },
    SettingsTab.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SettingsTabPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BookDetailsScreen]
class BookDetailsRoute extends _i9.PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    _i10.Key? key,
    int id = -1,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          BookDetailsRoute.name,
          args: BookDetailsRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'BookDetailsRoute';

  static const _i9.PageInfo<BookDetailsRouteArgs> page =
      _i9.PageInfo<BookDetailsRouteArgs>(name);
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({
    this.key,
    this.id = -1,
  });

  final _i10.Key? key;

  final int id;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.BooksScreen]
class BooksRoute extends _i9.PageRouteInfo<void> {
  const BooksRoute({List<_i9.PageRouteInfo>? children})
      : super(
          BooksRoute.name,
          initialChildren: children,
        );

  static const String name = 'BooksRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.BooksTabPage]
class BooksTab extends _i9.PageRouteInfo<void> {
  const BooksTab({List<_i9.PageRouteInfo>? children})
      : super(
          BooksTab.name,
          initialChildren: children,
        );

  static const String name = 'BooksTab';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ProfileDetailsScreen]
class ProfileDetailsRoute extends _i9.PageRouteInfo<void> {
  const ProfileDetailsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileDetailsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ProfileTabPage]
class ProfileTab extends _i9.PageRouteInfo<void> {
  const ProfileTab({List<_i9.PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SettingsDetailsScreen]
class SettingsDetailsRoute extends _i9.PageRouteInfo<void> {
  const SettingsDetailsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsDetailsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SettingsScreen]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SettingsTabPage]
class SettingsTab extends _i9.PageRouteInfo<void> {
  const SettingsTab({List<_i9.PageRouteInfo>? children})
      : super(
          SettingsTab.name,
          initialChildren: children,
        );

  static const String name = 'SettingsTab';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
