import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';
import 'package:log/log.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      routes: const [
        BooksRoute(),
        ProfileRoute(),
        SettingsRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              if (tabsRouter.activeIndex == index) {
                tabsRouter.innerRouterOf(tabsRouter.current.name)?.popTop();
              }
              tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(label: 'Books', icon: Icon(Icons.book)),
              BottomNavigationBarItem(
                  label: 'Profile', icon: Icon(Icons.person)),
              BottomNavigationBarItem(
                  label: 'Settings', icon: Icon(Icons.settings)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return LoggerWidget(child: this);
  }
}
