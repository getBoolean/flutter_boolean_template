import 'dart:math' as math;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef NavigationTypeResolver = NavigationType Function(BuildContext context);

class AutoAdaptiveRouterScaffold extends StatelessWidget {
  const AutoAdaptiveRouterScaffold({
    super.key,
    required this.destinations,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.navigationTypeResolver,
    this.drawerHeader,
    this.drawerFooter,
    this.fabInRail = true,
    this.includeBaseDestinationsInMenu = true,
    this.bottomNavigationOverflow = 5,
    this.railDestinationsOverflow = 7,
  });

  static AutoAdaptiveRouterScaffold of(BuildContext context) {
    final scaffold =
        context.findAncestorWidgetOfExactType<AutoAdaptiveRouterScaffold>();
    assert(scaffold != null,
        'No AutoAdaptiveRouterScaffold found in context. Wrap your app in an AutoAdaptiveRouterScaffold to fix this error.');
    return scaffold!;
  }

  /// The index into [destinations] for the current selected
  /// [RouterDestination].
  final List<RouterDestination> destinations;

  /// See [Scaffold.floatingActionButton].
  final FloatingActionButton? floatingActionButton;

  /// See [Scaffold.floatingActionButtonLocation].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// See [Scaffold.floatingActionButtonAnimator].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons].
  final List<Widget>? persistentFooterButtons;

  /// See [Scaffold.endDrawer].
  final Widget? endDrawer;

  /// See [Scaffold.drawerScrimColor].
  final Color? drawerScrimColor;

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;

  /// See [Scaffold.bottomSheet].
  final Widget? bottomSheet;

  /// See [Scaffold.resizeToAvoidBottomInset].
  final bool? resizeToAvoidBottomInset;

  /// See [Scaffold.primary].
  final bool primary;

  /// See [Scaffold.drawerDragStartBehavior].
  final DragStartBehavior drawerDragStartBehavior;

  /// See [Scaffold.extendBody].
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar].
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.drawerEdgeDragWidth].
  final double? drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture].
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture].
  final bool endDrawerEnableOpenDragGesture;

  /// Determines the navigation type that the scaffold uses.
  final NavigationTypeResolver? navigationTypeResolver;

  /// The leading item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no header.
  final Widget? drawerHeader;

  /// The footer item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no footer.
  final Widget? drawerFooter;

  /// Whether the [floatingActionButton] is inside or the rail or in the regular
  /// spot.
  ///
  /// If true, then [floatingActionButtonLocation] and
  /// [floatingActionButtonAnimation] are ignored.
  final bool fabInRail;

  /// Weather the overflow menu defaults to include overflow destinations and
  /// the overflow destinations.
  final bool includeBaseDestinationsInMenu;

  /// Maximum number of items to display in [BottomNavigationBar]
  final int bottomNavigationOverflow;

  /// Maximum number of items to display in [NavigationRail]
  final int railDestinationsOverflow;

  @override
  Widget build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver =
        this.navigationTypeResolver ?? defaultNavigationTypeResolver;
    final navigationType = navigationTypeResolver(context);
    final ThemeData theme = Theme.of(context);
    return AutoTabsRouter.pageView(
      routes: destinations.map((destination) => destination.route).toList(),
      animatePageTransition: navigationType == NavigationType.bottom,
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);

        final bottomDestinations = destinations.sublist(
          0,
          math.min(destinations.length, bottomNavigationOverflow),
        );

        final railDestinations = destinations.sublist(
          0,
          math.min(destinations.length, railDestinationsOverflow),
        );
        return Scaffold(
          appBar: navigationType == NavigationType.drawer
              ? AppBar(
                  title: Text(destinations[tabsRouter.activeIndex].title),
                  leading: const AutoLeadingButton(),
                )
              : null,
          body: Row(
            children: [
              if (navigationType == NavigationType.permanentDrawer) ...[
                Drawer(
                  child: Column(
                    children: [
                      if (drawerHeader != null) drawerHeader!,
                      for (final destination in destinations)
                        ListTile(
                          leading: Icon(destination.icon),
                          title: Text(destination.title),
                          selected: destinations.indexOf(destination) ==
                              tabsRouter.activeIndex,
                          onTap: () => _onDestinationSelected(
                            tabsRouter,
                            destinations.indexOf(destination),
                          ),
                          style: ListTileStyle.drawer,
                          selectedColor: theme.colorScheme.secondary,
                        ),
                      const Spacer(),
                      if (drawerFooter != null) drawerFooter!,
                    ],
                  ),
                ),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                ),
              ] else if (navigationType == NavigationType.rail) ...[
                NavigationRail(
                  leading: fabInRail ? floatingActionButton : null,
                  destinations: [
                    for (final destination in railDestinations)
                      NavigationRailDestination(
                        icon: Icon(destination.icon),
                        label: Text(destination.title),
                      ),
                  ],
                  selectedIndex: tabsRouter.activeIndex,
                  onDestinationSelected: (index) {
                    _onDestinationSelected(tabsRouter, index);
                  },
                ),
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                ),
              ],
              Expanded(child: child),
            ],
          ),
          drawer: switch (navigationType) {
            NavigationType.drawer => Drawer(
                child: Column(
                  children: [
                    if (drawerHeader != null) drawerHeader!,
                    for (final destination in destinations)
                      ListTile(
                        leading: Icon(destination.icon),
                        title: Text(destination.title),
                        selected: destinations.indexOf(destination) ==
                            tabsRouter.activeIndex,
                        onTap: () => _onDestinationSelected(
                          tabsRouter,
                          destinations.indexOf(destination),
                        ),
                        style: ListTileStyle.drawer,
                        selectedColor: theme.colorScheme.secondary,
                      ),
                    const Spacer(),
                    if (drawerFooter != null) drawerFooter!,
                  ],
                ),
              ),
            _ => null,
          },
          bottomNavigationBar: switch (navigationType) {
            NavigationType.bottom => BottomNavigationBar(
                key: tabsRouter.key,
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  _onDestinationSelected(tabsRouter, index);
                },
                items: [
                  for (final destination in bottomDestinations)
                    BottomNavigationBarItem(
                      label: destination.title,
                      icon: Icon(destination.icon),
                    ),
                ],
              ),
            _ => null,
          },
          floatingActionButton:
              (fabInRail && navigationType != NavigationType.bottom)
                  ? null
                  : floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          persistentFooterButtons: persistentFooterButtons,
          endDrawer: endDrawer,
          bottomSheet: bottomSheet,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          primary: primary,
          drawerDragStartBehavior: drawerDragStartBehavior,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawerScrimColor: drawerScrimColor,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        );
      },
    );
  }
}

void _onDestinationSelected(TabsRouter tabsRouter, int index) {
  if (tabsRouter.activeIndex == index) {
    tabsRouter.innerRouterOf(tabsRouter.current.name)?.popTop();
  }
  tabsRouter.setActiveIndex(index);
}

// The navigation mechanism to configure the [Scaffold] with.
enum NavigationType {
  // Used to configure a [Scaffold] with a [BottomNavigationBar].
  bottom,

  // Used to configure a [Scaffold] with a [NavigationRail].
  rail,

  // Used to configure a [Scaffold] with a modal [Drawer].
  drawer,

  // Used to configure a [Scaffold] with an always open [Drawer].
  permanentDrawer,
}

class RouterDestination {
  const RouterDestination({
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;
  final IconData icon;
  final PageRouteInfo<void> route;
}

class AutoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AutoAppBar({super.key, this.title, this.navigationTypeResolver});

  final Widget? title;

  /// Determines the navigation type that the scaffold uses.
  final NavigationTypeResolver? navigationTypeResolver;

  @override
  State<AutoAppBar> createState() => _AutoAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AutoAppBarState extends State<AutoAppBar> {
  @override
  Widget build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver =
        widget.navigationTypeResolver ?? defaultNavigationTypeResolver;
    final navigationType = navigationTypeResolver(context);
    final destinationScaffold = AutoAdaptiveRouterScaffold.of(context);
    final tabsRouter = AutoTabsRouter.of(context, watch: true);
    return switch (navigationType) {
      NavigationType.drawer => const SizedBox.shrink(),
      _ => AppBar(
          title: widget.title ??
              Text(
                destinationScaffold.destinations[tabsRouter.activeIndex].title,
              ),
          leading: const AutoLeadingButton(),
        ),
    };
  }
}

NavigationType defaultNavigationTypeResolver(BuildContext context) {
  if (defaultIsLargeScreen(context)) {
    return NavigationType.permanentDrawer;
  } else if (defaultIsMediumScreen(context)) {
    return NavigationType.rail;
  } else {
    return NavigationType.bottom;
  }
}

bool defaultIsLargeScreen(BuildContext context) =>
    getWindowType(context) >= AdaptiveWindowType.large;
bool defaultIsMediumScreen(BuildContext context) =>
    getWindowType(context) == AdaptiveWindowType.medium;
