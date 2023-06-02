import 'package:auto_route/auto_route.dart';
import 'package:logs/logs.dart';

import '../ui/ui.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  AppRouter({required this.log});

  final Logger log;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: '/dashboard',
          children: [
            RedirectRoute(path: '', redirectTo: 'books'),
            AutoRoute(path: 'books', page: BooksTab.page, children: [
              AutoRoute(path: '', page: BooksRoute.page),
              AutoRoute(path: 'details', page: BookDetailsRoute.page),
            ]),
            AutoRoute(path: 'profile', page: ProfileTab.page, children: [
              AutoRoute(path: '', page: ProfileRoute.page),
              AutoRoute(path: 'comments', page: ProfileDetailsRoute.page),
            ]),
            AutoRoute(path: 'settings', page: SettingsTab.page, children: [
              AutoRoute(path: '', page: SettingsRoute.page),
              AutoRoute(path: 'option', page: SettingsDetailsRoute.page),
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
