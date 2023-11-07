import 'package:auto_route/auto_route.dart';
import 'package:flutter_boolean_template/src/routing/ui/ui.dart';
import 'package:log/log.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  AppRouter({required this.log});

  final Logger log;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        // route inspiration: https://github.com/Milad-Akarie/auto_route_library/issues/1548
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: '/',
          children: [
            RedirectRoute(path: '', redirectTo: 'books'),
            AutoRoute(path: 'books', page: BooksTab.page, children: [
              AutoRoute(
                path: '',
                page: BooksRoute.page,
                title: (context, data) => 'Books',
              ),
              AutoRoute(
                path: 'details',
                page: BookDetailsRoute.page,
                title: (context, data) => 'Book Details',
              ),
            ]),
            AutoRoute(path: 'profile', page: ProfileTab.page, children: [
              AutoRoute(
                path: '',
                page: ProfileRoute.page,
                title: (context, data) => 'Profile',
              ),
              AutoRoute(
                path: 'comments',
                page: ProfileDetailsRoute.page,
                title: (context, data) => 'Profile Details',
              ),
            ]),
            AutoRoute(path: 'settings', page: SettingsTab.page, children: [
              AutoRoute(
                path: '',
                page: SettingsRoute.page,
                title: (context, data) => 'Settings',
              ),
              AutoRoute(
                path: 'option',
                page: SettingsDetailsRoute.page,
                title: (context, data) => 'Setting Details',
              ),
            ]),
          ],
        ),
      ];
}

@RoutePage(name: 'BooksTab')
class BooksTabPage extends AutoRouter {
  const BooksTabPage({super.key});
}

@RoutePage(name: 'ProfileTab')
class ProfileTabPage extends AutoRouter {
  const ProfileTabPage({super.key});
}

@RoutePage(name: 'SettingsTab')
class SettingsTabPage extends AutoRouter {
  const SettingsTabPage({super.key});
}
