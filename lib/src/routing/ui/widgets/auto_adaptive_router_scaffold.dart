import 'dart:async';
import 'dart:math' as math;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/constrained_scrollable_child.dart';
import 'package:log/log.dart';

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
    this.topBarStart,
    this.topBarEnd,
    this.isTabBarScrollable = true,
    this.tabAlignment = TabAlignment.start,
    this.divider,
    this.appBarLeadingButtonBuilder,
    this.leadingButtonBuilder,
    this.tabBarBuilder,
    this.bottomNavigationBarBuilder,
    this.drawerBuilder,
    this.permanentDrawerBuilder,
    this.railBuilder,
    this.sliverAppBarBuilder,
    this.topBarBuilder,
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
  ///
  /// Only used for [NavigationType.bottom], [NavigationType.drawer], and [NavigationType.rail]
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
  final Widget? topBarStart;

  /// The trailing item in the [TabBar].
  final Widget? topBarEnd;

  /// The alignment for the tabs in the [TabBar]
  final TabAlignment tabAlignment;

  /// Whether the [TabBar] can be scrolled horizontally.
  ///
  /// If [isTabBarScrollable] is true, then each tab is as wide as needed for its label
  /// and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
  /// share of the available space.
  final bool isTabBarScrollable;

  /// The [VerticalDivider] between the [Drawer]/[NavigationRail] and the body.
  final Widget? divider;

  final AutoLeadingButton Function(BuildContext context)?
      appBarLeadingButtonBuilder;

  final AutoLeadingButton Function(BuildContext context)? leadingButtonBuilder;

  /// Custom builder for [NavigationType.top]'s [TabBar]
  ///
  /// If not null, then [isTabBarScrollable], and [tabAlignment] are ignored for this type.
  final TabBar Function(
    BuildContext context,
    void Function(int index) onDestinationSelected,
  )? tabBarBuilder;

  /// Custom builder for [NavigationType.top]
  final PreferredSize Function(
    BuildContext context,
    AutoLeadingButton leadingButton,
    TabBar tabBar,
    void Function(int index) onDestinationSelected,
  )? topBarBuilder;

  /// Custom builder for [NavigationType.bottom]
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    List<RouterDestination> bottomDestinations,
    void Function(int index) onDestinationSelected,
  )? bottomNavigationBarBuilder;

  /// Custom builder for [NavigationType.drawer]
  ///
  /// If not null, then [drawerHeader] and [drawerFooter] are ignored for this type.
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    void Function(int index) onDestinationSelected,
  )? drawerBuilder;

  /// Custom builder for [NavigationType.permanentDrawer]
  ///
  /// If not null, then [drawerHeader] and [drawerFooter] are ignored for this type.
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    AutoLeadingButton leadingButton,
    void Function(int index) onDestinationSelected,
  )? permanentDrawerBuilder;

  /// Custom builder for [NavigationType.rail]
  ///
  /// If not null, then [fabInRail] and [floatingActionButton] are ignored for this type.
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    List<RouterDestination> railDestinations,
    AutoLeadingButton leadingButton,
    void Function(int index) onDestinationSelected,
  )? railBuilder;

  /// Custom [SliverAppBar] builder for [NavigationType.drawer] and [NavigationType.bottom]
  ///
  /// A sliver must be returned from this builder.
  final Widget Function(
    BuildContext context,
    NavigationType navigationType,
    String? title,
  )? sliverAppBarBuilder;

  @override
  State<AutoAdaptiveRouterScaffold> createState() =>
      AutoAdaptiveRouterScaffoldState();
}

class AutoAdaptiveRouterScaffoldState
    extends State<AutoAdaptiveRouterScaffold> {
  Map<int, String> appBarTitle = {};

  void setAppBarTitle(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    final routeData = RouteData.of(context);
    appBarTitle[tabsRouter.activeIndex] = routeData.title(context);
    scheduleMicrotask(() => setState(() {}));
  }

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

        final leadingButtonBuilder =
            widget.leadingButtonBuilder ?? _defaultBuildAutoLeadingButton;
        final buildBottomNavigationBar = widget.bottomNavigationBarBuilder ??
            _defaultBottomNavigationBarBuilder;
        final bottomNavigationBar = buildBottomNavigationBar(
          context,
          tabsRouter.activeIndex,
          bottomDestinations,
          onDestinationSelectedHelper,
        );

        final buildDrawer = widget.drawerBuilder ?? _defaultBuildDrawer;
        final drawer = buildDrawer(
          context,
          tabsRouter.activeIndex,
          onDestinationSelectedHelper,
        );

        final buildSliverAppBar = widget.sliverAppBarBuilder ??
            _defaultBuildDrawerNavigationTypeSliverAppBar;
        final sliverAppBar = buildSliverAppBar(
          context,
          navigationType,
          appBarTitle[tabsRouter.activeIndex],
        );

        final buildPermanentDrawer =
            widget.permanentDrawerBuilder ?? _defaultBuildPermanentDrawer;
        final permanentDrawer = buildPermanentDrawer(
          context,
          tabsRouter.activeIndex,
          leadingButtonBuilder(context),
          onDestinationSelectedHelper,
        );

        final buildRail = widget.railBuilder ?? _defaultBuildNavigationRail;
        final navigationRail = buildRail(
          context,
          tabsRouter.activeIndex,
          railDestinations,
          leadingButtonBuilder(context),
          onDestinationSelectedHelper,
        );
        final buildTabBar = widget.tabBarBuilder ?? _defaultTabBarBuilder;
        final tabBar = buildTabBar(context, onDestinationSelectedHelper);

        final buildTopBar = widget.topBarBuilder ?? _defaultTopBarBuilder;
        final topBar = buildTopBar(context, leadingButtonBuilder(context),
            tabBar, onDestinationSelectedHelper);
        return DefaultTabController(
          initialIndex: tabsRouter.activeIndex,
          length: widget.destinations.length,
          child: Scaffold(
            appBar: navigationType == NavigationType.top ? topBar : null,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  if (navigationType != NavigationType.top &&
                      navigationType != NavigationType.rail)
                    sliverAppBar
                ];
              },
              body: Row(
                children: [
                  if (navigationType == NavigationType.permanentDrawer) ...[
                    ConstrainedScrollableChild(child: permanentDrawer),
                    widget.divider ??
                        const VerticalDivider(
                          width: 1,
                          thickness: 1,
                        ),
                  ] else if (navigationType == NavigationType.rail) ...[
                    ConstrainedScrollableChild(child: navigationRail),
                    widget.divider ??
                        const VerticalDivider(
                          width: 1,
                          thickness: 1,
                        ),
                  ],
                  Expanded(child: child),
                ],
              ),
            ),
            drawer: switch (navigationType) {
              NavigationType.drawer =>
                ConstrainedScrollableChild(child: drawer),
              _ => null,
            },
            bottomNavigationBar: switch (navigationType) {
              NavigationType.bottom => bottomNavigationBar,
              _ => null,
            },
            floatingActionButton: (widget.fabInRail &&
                    !(navigationType == NavigationType.bottom ||
                        navigationType == NavigationType.drawer))
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

  PreferredSize _defaultTopBarBuilder(
    BuildContext context,
    AutoLeadingButton leadingButton,
    TabBar tabBar,
    void Function(int index) onDestinationSelected,
  ) {
    return PreferredSize(
      preferredSize: tabBar.preferredSize,
      child: ConstrainedScrollableChild(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (widget.topBarStart != null) widget.topBarStart!,
            leadingButton,
            tabBar,
            const Spacer(),
            if (widget.topBarEnd != null) widget.topBarEnd!,
          ],
        ),
      ),
    );
  }

  Widget _defaultBuildNavigationRail(
    BuildContext context,
    int selectedIndex,
    List<RouterDestination> railDestinations,
    AutoLeadingButton leadingButton,
    void Function(int index) onDestinationSelected,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: NavigationRail(
            leading: leadingButton,
            groupAlignment: 1.0,
            destinations: [
              for (final destination in railDestinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  label: Text(destination.title),
                ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
          ),
        ),
        if (widget.fabInRail)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
            child: widget.floatingActionButton,
          ),
      ],
    );
  }

  Widget _defaultBuildPermanentDrawer(
    BuildContext context,
    int selectedIndex,
    AutoLeadingButton leadingButton,
    void Function(int index) onDestinationSelected,
  ) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              if (widget.drawerHeader != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: widget.drawerHeader,
                ),
                const Spacer(),
              ],
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: leadingButton,
              ),
            ],
          ),
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

  AutoLeadingButton _defaultBuildAutoLeadingButton(BuildContext context) {
    return AutoLeadingButton(
      builder: (context, leadingType, action) => switch (leadingType) {
        LeadingType.back => BackButton(onPressed: action),
        LeadingType.drawer => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: action,
            iconSize: Theme.of(context).iconTheme.size ?? 24,
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        LeadingType.close => CloseButton(onPressed: action),
        LeadingType.noLeading => IconButton(
            icon: const BackButtonIcon(),
            iconSize: Theme.of(context).iconTheme.size ?? 24,
            onPressed: action,
          ),
      },
    );
  }

  Widget _defaultBuildDrawer(
    BuildContext context,
    int selectedIndex,
    void Function(int index) onDestinationSelected,
  ) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          if (widget.drawerHeader != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: widget.drawerHeader,
              ),
            ),
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
    BuildContext context,
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
    BuildContext context,
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

  Widget _defaultBuildDrawerNavigationTypeSliverAppBar(
    BuildContext context,
    NavigationType navigationType,
    String? title,
  ) {
    return switch (navigationType) {
      NavigationType.bottom => SliverAppBar(
          leading: const AutoLeadingButton(),
          title: title == null ? null : Text(title),
          elevation: 10.0,
          automaticallyImplyLeading: false,
          expandedHeight: 50,
          floating: true,
          snap: true,
        ),
      NavigationType.drawer => SliverAppBar(
          leading: const AutoLeadingButton(),
          title: title == null ? null : Text(title),
          elevation: 10.0,
          automaticallyImplyLeading: false,
          expandedHeight: 50,
          floating: true,
          snap: true,
        ),
      _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
    };
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

class AppObserver extends AutoRouteObserver {
  final log = Logger('AppObserver');
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.info('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.info(
        'Route popped: ${route.settings.name}, new route: ${previousRoute?.settings.name}');
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log.info(
        'Tab route visited: ${route.name}, previous route: ${previousRoute?.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log.info(
        'Tab route re-visited: ${route.name}, previous route: ${previousRoute.name}');
  }
}
