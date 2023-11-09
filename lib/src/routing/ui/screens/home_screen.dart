import 'package:auto_route/auto_route.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/routing/router/app_router.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_adaptive_router_scaffold.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log/log.dart';

@RoutePage<String>()
class HomeScreen extends ConsumerStatefulWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return LoggerWidget(child: this);
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static final _destinations = [
    const RouterDestination(
      title: 'Books',
      icon: Icons.book,
      route: BooksRoute(),
    ),
    const RouterDestination(
      title: 'Profile',
      icon: Icons.person,
      route: ProfileRoute(),
    ),
    const RouterDestination(
      title: 'Settings',
      icon: Icons.settings,
      route: SettingsRoute(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final settings = ref.watch(settingsServiceProvider);
    return SafeArea(
      child: AutoAdaptiveRouterScaffold(
        navigationTypeResolver: _resolveNavigationType,
        tabBarStart: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            kAppName,
            style: theme.textTheme.titleMedium?.merge(GoogleFonts.robotoMono()),
          ),
        ),
        tabBarEnd: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: settings.isBannerShowing ? 60 : 4),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
        drawerHeader: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 16, bottom: 16),
              child: Text(
                kAppName,
                style: theme.textTheme.titleMedium
                    ?.merge(GoogleFonts.robotoMono()),
              ),
            ),
          ],
        ),
        drawerFooter: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Add'),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        destinations: _destinations,
      ),
    );
  }

  NavigationType _resolveNavigationType(BuildContext context) {
    final (_, form, orientation) = getDeviceDetails(context);
    if (orientation == Orientation.portrait) {
      return switch (form) {
        DeviceForm.largeDesktop => NavigationType.top,
        DeviceForm.desktop => NavigationType.top,
        DeviceForm.tablet => NavigationType.top,
        DeviceForm.largePhone => NavigationType.bottom,
        DeviceForm.phone => NavigationType.bottom,
      };
    } else {
      return switch (form) {
        DeviceForm.largeDesktop => NavigationType.top,
        DeviceForm.desktop => NavigationType.permanentDrawer,
        DeviceForm.tablet => NavigationType.permanentDrawer,
        DeviceForm.largePhone => NavigationType.rail,
        DeviceForm.phone => NavigationType.drawer,
      };
    }
  }
}
