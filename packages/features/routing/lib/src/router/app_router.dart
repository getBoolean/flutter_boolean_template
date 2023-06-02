import 'package:auto_route/auto_route.dart';
import 'package:logs/logs.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'ScreenShell,Route')
class AppRouter extends $AppRouter {
  AppRouter({required this.log});

  final Logger log;

  @override
  List<AutoRoute> get routes => [
        //HomeScreen is generated as HomeRoute because
        //of the replaceInRouteName property
        AutoRoute(page: HomeRoute.page, initial: true),
      ];
}
