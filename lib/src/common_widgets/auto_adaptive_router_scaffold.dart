import 'dart:math' as math;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef NavigationTypeResolver = NavigationType Function(BuildContext context);

class AutoAdaptiveRouterScaffold extends StatefulWidget {
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
    this.tabBarStart,
    this.tabBarEnd,
    this.isTabBarScrollable = true,
    this.tabAlignment = TabAlignment.start,
    this.drawerDivider,
    this.tabBarBuilder,
    this.bottomNavigationBarBuilder,
    this.drawerBuilder,
    this.permanentDrawerBuilder,
    this.railBuilder,
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
  /// [floatingActionButtonAnimator] are ignored.
  final bool fabInRail;

  /// Weather the overflow menu defaults to include overflow destinations and
  /// the overflow destinations.
  final bool includeBaseDestinationsInMenu;

  /// Maximum number of items to display in [NavigationBar]
  final int bottomNavigationOverflow;

  /// Maximum number of items to display in [NavigationRail]
  final int railDestinationsOverflow;

  /// The starting item in the [TabBar].
  final Widget? tabBarStart;

  /// The trailing item in the [TabBar].
  final Widget? tabBarEnd;

  /// The alignment for the tabs in the [TabBar]
  final TabAlignment tabAlignment;

  /// Whether the [TabBar] can be scrolled horizontally.
  ///
  /// If [isTabBarScrollable] is true, then each tab is as wide as needed for its label
  /// and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
  /// share of the available space.
  final bool isTabBarScrollable;

  final VerticalDivider? drawerDivider;

  final TabBar Function(
    void Function(int index) onDestinationSelected,
  )? tabBarBuilder;

  final Widget Function(
    int selectedIndex,
    List<RouterDestination> bottomDestinations,
    void Function(int index) onDestinationSelected,
  )? bottomNavigationBarBuilder;

  final Widget Function(
    int selectedIndex,
    void Function(int index) onDestinationSelected,
  )? drawerBuilder;

  final Widget Function(
    int selectedIndex,
    void Function(int index) onDestinationSelected,
  )? permanentDrawerBuilder;

  final Widget Function(
    int selectedIndex,
    List<RouterDestination> railDestinations,
    void Function(int index) onDestinationSelected,
  )? railBuilder;

  @override
  State<AutoAdaptiveRouterScaffold> createState() =>
      _AutoAdaptiveRouterScaffoldState();
}

class _AutoAdaptiveRouterScaffoldState
    extends State<AutoAdaptiveRouterScaffold> {
  @override
  Widget build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver =
        widget.navigationTypeResolver ?? defaultNavigationTypeResolver;
    final navigationType = navigationTypeResolver(context);
    return AutoTabsRouter.pageView(
      routes:
          widget.destinations.map((destination) => destination.route).toList(),
      animatePageTransition: navigationType == NavigationType.bottom ||
          navigationType == NavigationType.top,
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        onDestinationSelectedHelper(int index) =>
            _onDestinationSelected(tabsRouter, index);

        final bottomDestinations = widget.destinations.sublist(
          0,
          math.min(widget.destinations.length, widget.bottomNavigationOverflow),
        );

        final railDestinations = widget.destinations.sublist(
          0,
          math.min(widget.destinations.length, widget.railDestinationsOverflow),
        );
        final buildTabBar = widget.tabBarBuilder ?? _defaultTabBarBuilder;
        final tabBar = buildTabBar(onDestinationSelectedHelper);

        final buildBottomNavigationBar = widget.bottomNavigationBarBuilder ??
            _defaultBottomNavigationBarBuilder;
        final bottomNavigationBar = buildBottomNavigationBar(
          tabsRouter.activeIndex,
          bottomDestinations,
          onDestinationSelectedHelper,
        );

        final buildDrawer = widget.drawerBuilder ?? _defaultBuildDrawer;
        final drawer = buildDrawer(
          tabsRouter.activeIndex,
          onDestinationSelectedHelper,
        );

        final buildPermanentDrawer =
            widget.permanentDrawerBuilder ?? _defaultBuildPermanentDrawer;
        final permanentDrawer = buildPermanentDrawer(
          tabsRouter.activeIndex,
          onDestinationSelectedHelper,
        );

        final buildRail = widget.railBuilder ?? _defaultBuildNavigationRail;
        final navigationRail = buildRail(
          tabsRouter.activeIndex,
          railDestinations,
          onDestinationSelectedHelper,
        );

        return DefaultTabController(
          initialIndex: tabsRouter.activeIndex,
          length: widget.destinations.length,
          child: Scaffold(
            appBar: navigationType == NavigationType.drawer
                ? AppBar(
                    title:
                        Text(widget.destinations[tabsRouter.activeIndex].title),
                    leading: const AutoLeadingButton(),
                    leadingWidth:
                        navigationType == NavigationType.rail ? 72.0 : 56.0,
                  )
                : navigationType == NavigationType.top
                    ? PreferredSize(
                        preferredSize: tabBar.preferredSize,
                        child: Row(
                          children: [
                            if (widget.tabBarStart != null) widget.tabBarStart!,
                            tabBar,
                            const Spacer(),
                            if (widget.tabBarEnd != null) widget.tabBarEnd!,
                          ],
                        ),
                      )
                    : null,
            body: Row(
              children: [
                if (navigationType == NavigationType.permanentDrawer) ...[
                  permanentDrawer,
                  widget.drawerDivider ??
                      const VerticalDivider(
                        width: 1,
                        thickness: 1,
                      ),
                ] else if (navigationType == NavigationType.rail) ...[
                  navigationRail,
                  widget.drawerDivider ??
                      const VerticalDivider(
                        width: 1,
                        thickness: 1,
                      ),
                ],
                Expanded(child: child),
              ],
            ),
            drawer: switch (navigationType) {
              NavigationType.drawer => drawer,
              _ => null,
            },
            bottomNavigationBar: switch (navigationType) {
              NavigationType.bottom => bottomNavigationBar,
              _ => null,
            },
            floatingActionButton:
                (widget.fabInRail && navigationType != NavigationType.bottom)
                    ? null
                    : widget.floatingActionButton,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
            persistentFooterButtons: widget.persistentFooterButtons,
            endDrawer: widget.endDrawer,
            bottomSheet: widget.bottomSheet,
            backgroundColor: widget.backgroundColor,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
            primary: widget.primary,
            drawerDragStartBehavior: widget.drawerDragStartBehavior,
            extendBody: widget.extendBody,
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
            drawerScrimColor: widget.drawerScrimColor,
            drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
            endDrawerEnableOpenDragGesture:
                widget.endDrawerEnableOpenDragGesture,
          ),
        );
      },
    );
  }

  NavigationRail _defaultBuildNavigationRail(
    int selectedIndex,
    List<RouterDestination> railDestinations,
    void Function(int index) onDestinationSelected,
  ) {
    return NavigationRail(
      leading: widget.fabInRail
          ? Padding(
              padding: const EdgeInsets.all(4.0),
              child: widget.floatingActionButton,
            )
          : null,
      destinations: [
        for (final destination in railDestinations)
          NavigationRailDestination(
            icon: Icon(destination.icon),
            label: Text(destination.title),
          ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }

  Drawer _defaultBuildPermanentDrawer(
    int selectedIndex,
    void Function(int index) onDestinationSelected,
  ) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          if (widget.drawerHeader != null) widget.drawerHeader!,
          for (final destination in widget.destinations)
            ListTile(
              leading: Icon(destination.icon),
              title: Text(destination.title),
              selected:
                  widget.destinations.indexOf(destination) == selectedIndex,
              onTap: () => onDestinationSelected(
                widget.destinations.indexOf(destination),
              ),
              style: ListTileStyle.drawer,
              selectedColor: theme.colorScheme.secondary,
            ),
          const Spacer(),
          if (widget.drawerFooter != null) widget.drawerFooter!,
        ],
      ),
    );
  }

  Drawer _defaultBuildDrawer(
    int selectedIndex,
    void Function(int index) onDestinationSelected,
  ) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          if (widget.drawerHeader != null) widget.drawerHeader!,
          for (final destination in widget.destinations)
            ListTile(
              leading: Icon(destination.icon),
              title: Text(destination.title),
              selected:
                  widget.destinations.indexOf(destination) == selectedIndex,
              onTap: () => onDestinationSelected(
                widget.destinations.indexOf(destination),
              ),
              style: ListTileStyle.drawer,
              selectedColor: theme.colorScheme.secondary,
            ),
          const Spacer(),
          if (widget.drawerFooter != null) widget.drawerFooter!,
        ],
      ),
    );
  }

  Widget _defaultBottomNavigationBarBuilder(
    int selectedIndex,
    List<RouterDestination> bottomDestinations,
    void Function(int index) onDestinationSelected,
  ) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: [
        for (final destination in bottomDestinations)
          NavigationDestination(
            label: destination.title,
            icon: Icon(destination.icon),
          ),
      ],
    );
  }

  TabBar _defaultTabBarBuilder(
    void Function(int index) onDestinationSelected,
  ) {
    return TabBar(
      onTap: onDestinationSelected,
      isScrollable: widget.isTabBarScrollable,
      tabAlignment: widget.tabAlignment,
      tabs: <Tab>[
        for (final destination in widget.destinations)
          Tab(child: Text(destination.title)),
      ],
    );
  }
}

void _onDestinationSelected(TabsRouter tabsRouter, int index) {
  if (tabsRouter.activeIndex == index) {
    tabsRouter.innerRouterOf(tabsRouter.current.name)?.popTop();
  }
  tabsRouter.setActiveIndex(index);
}

/// The navigation mechanism to configure the [Scaffold] with.
enum NavigationType {
  /// Used to configure a [Scaffold] with a [NavigationBar].
  bottom,

  /// Used to configure a [Scaffold] with a [NavigationRail].
  rail,

  /// Used to configure a [Scaffold] with a modal [Drawer].
  drawer,

  /// Used to configure a [Scaffold] with an always open [Drawer].
  permanentDrawer,

  /// Used to configure a [Scaffold] with a [TabBar]
  top,
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
