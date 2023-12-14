import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/responsive_scaffold.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RootScaffoldShell extends ConsumerStatefulWidget {
  const RootScaffoldShell({
    super.key,
    required this.navigationShell,
    required this.destinations,
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  final List<RouterDestination> destinations;

  @override
  ConsumerState<RootScaffoldShell> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<RootScaffoldShell> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final settings = ref.watch(settingsServiceProvider);
    return SafeArea(
      child: ResponsiveScaffold(
        body: widget.navigationShell,
        currentIndexProvider: () => widget.navigationShell.currentIndex,
        goToIndex: widget.navigationShell.goBranch,
        navigationTypeResolver: _resolveNavigationType,
        topBarStart: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            kAppName,
            style: theme.textTheme.titleMedium?.merge(GoogleFonts.robotoMono()),
          ),
        ),
        topBarEnd: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: settings.isBannerShowing ? 60 : 4),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
        drawerHeader: Row(
          children: [
            Text(
              kAppName,
              style:
                  theme.textTheme.titleMedium?.merge(GoogleFonts.robotoMono()),
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
        destinations: widget.destinations,
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
