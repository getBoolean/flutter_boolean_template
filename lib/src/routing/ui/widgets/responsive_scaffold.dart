import 'dart:math' as math;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/constrained_scrollable_child.dart';
import 'package:log/log.dart';

typedef NavigationTypeResolver = NavigationType Function(BuildContext context);

typedef GoToIndexCallback = void Function(
  int newIndex, {
  bool initialLocation,
});

class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({
    super.key,
    required this.destinations,
    required this.currentIndexProvider,
    required this.title,
    required this.child,
    required this.goToIndex,
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
    this.leadingButtonBuilder,
    this.tabBarBuilder,
    this.bottomNavigationBarBuilder,
    this.drawerBuilder,
    this.permanentDrawerBuilder,
    this.railBuilder,
    this.sliverAppBarBuilder,
    this.topBarBuilder,
  });

  static ResponsiveScaffold of(BuildContext context) {
    final scaffold =
        context.findAncestorWidgetOfExactType<ResponsiveScaffold>();
    assert(scaffold != null,
        'No AutoAdaptiveRouterScaffold found in context. Wrap your app in an AutoAdaptiveRouterScaffold to fix this error.');
    return scaffold!;
  }

  final int Function() currentIndexProvider;

  final GoToIndexCallback goToIndex;

  final String title;

  final Widget child;

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

  final Widget Function(BuildContext context)? leadingButtonBuilder;

  /// Custom builder for [NavigationType.top]'s [TabBar]
  ///
  /// If not null, then [isTabBarScrollable], and [tabAlignment] are ignored for this type.
  final TabBar Function(
    BuildContext context,
    void Function(int index) setPage,
  )? tabBarBuilder;

  /// Custom builder for [NavigationType.top]
  final PreferredSize Function(
    BuildContext context,
    TabBar tabBar,
    void Function(int index) setPage,
  )? topBarBuilder;

  /// Custom builder for [NavigationType.bottom]
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    List<RouterDestination> bottomDestinations,
    void Function(int index) setPage,
  )? bottomNavigationBarBuilder;

  /// Custom builder for [NavigationType.drawer]
  ///
  /// If not null, then [drawerHeader] and [drawerFooter] are ignored for this type.
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    void Function(int index) setPage,
  )? drawerBuilder;

  /// Custom builder for [NavigationType.permanentDrawer]
  ///
  /// If not null, then [drawerHeader] and [drawerFooter] are ignored for this type.
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    void Function(int index) setPage,
  )? permanentDrawerBuilder;

  /// Custom builder for [NavigationType.rail]
  ///
  /// If not null, then [fabInRail] and [floatingActionButton] are ignored for this type.
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    List<RouterDestination> railDestinations,
    void Function(int index) setPage,
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
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  @override
  Widget build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver =
        widget.navigationTypeResolver ?? defaultNavigationTypeResolver;
    final navigationType = navigationTypeResolver(context);

    final bottomDestinations = widget.destinations.sublist(
      0,
      math.min(widget.destinations.length, widget.bottomNavigationOverflow),
    );

    final railDestinations = widget.destinations.sublist(
      0,
      math.min(widget.destinations.length, widget.railDestinationsOverflow),
    );

    final buildBottomNavigationBar =
        widget.bottomNavigationBarBuilder ?? _defaultBottomNavigationBarBuilder;
    final selectedIndex = widget.currentIndexProvider();
    final bottomNavigationBar = buildBottomNavigationBar(
      context,
      selectedIndex,
      bottomDestinations,
      _setPage,
    );

    final buildDrawer = widget.drawerBuilder ?? _defaultBuildDrawer;
    final drawer = buildDrawer(
      context,
      selectedIndex,
      _setPage,
    );

    final buildSliverAppBar = widget.sliverAppBarBuilder ??
        _defaultBuildDrawerNavigationTypeSliverAppBar;
    final sliverAppBar = buildSliverAppBar(
      context,
      navigationType,
      // appBarTitle[selectedIndex],
      widget.title,
    );

    final buildPermanentDrawer =
        widget.permanentDrawerBuilder ?? _defaultBuildPermanentDrawer;
    final permanentDrawer = buildPermanentDrawer(
      context,
      selectedIndex,
      _setPage,
    );

    final buildRail = widget.railBuilder ?? _defaultBuildNavigationRail;
    final navigationRail = buildRail(
      context,
      selectedIndex,
      railDestinations,
      _setPage,
    );
    final buildTabBar = widget.tabBarBuilder ?? _defaultTabBarBuilder;
    final tabBar = buildTabBar(context, _setPage);

    final buildTopBar = widget.topBarBuilder ?? _defaultTopBarBuilder;
    final topBar = buildTopBar(context, tabBar, _setPage);
    final hasDrawer = navigationType == NavigationType.drawer;
    final hasBottomNavigationBar = navigationType == NavigationType.bottom;
    return DefaultTabController(
      initialIndex: selectedIndex,
      length: widget.destinations.length,
      child: Scaffold(
        appBar: navigationType == NavigationType.top ? topBar : null,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
              Expanded(child: widget.child),
            ],
          ),
        ),
        drawer: hasDrawer ? ConstrainedScrollableChild(child: drawer) : null,
        bottomNavigationBar:
            hasBottomNavigationBar ? bottomNavigationBar : null,
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
        endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      ),
    );
  }

  void _setPage(int index) {
    final previousIndex = widget.currentIndexProvider();
    widget.goToIndex(index, initialLocation: index == previousIndex);
  }

  PreferredSize _defaultTopBarBuilder(
    BuildContext context,
    TabBar tabBar,
    void Function(int index) setPage,
  ) {
    return PreferredSize(
      preferredSize: tabBar.preferredSize,
      child: ConstrainedScrollableChild(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (widget.topBarStart != null) widget.topBarStart!,
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
    void Function(int index) setPage,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: NavigationRail(
            groupAlignment: 1.0,
            destinations: [
              for (final destination in railDestinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  label: Text(destination.title),
                ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: setPage,
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
    void Function(int index) setPage,
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
            ],
          ),
          for (final destination in widget.destinations)
            ListTile(
              leading: Icon(destination.icon),
              title: Text(destination.title),
              selected:
                  widget.destinations.indexOf(destination) == selectedIndex,
              onTap: () => setPage(
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

  Widget _defaultBuildDrawer(
    BuildContext context,
    int selectedIndex,
    void Function(int index) setPage,
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
              onTap: () => setPage(
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
    void Function(int index) setPage,
  ) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: setPage,
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
    void Function(int index) setPage,
  ) {
    return TabBar(
      onTap: setPage,
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
          // leading: const AutoLeadingButton(),
          title: title == null ? null : Text(title),
          elevation: 10.0,
          automaticallyImplyLeading: false,
          expandedHeight: 50,
          floating: true,
          snap: true,
        ),
      NavigationType.drawer => SliverAppBar(
          // leading: const AutoLeadingButton(),
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
    required this.navigatorKey,
  });

  final String title;
  final IconData icon;
  final GlobalKey<NavigatorState> navigatorKey;
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

class AppObserver extends NavigatorObserver {
  final log = Logger('AppObserver');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.info(
        'New route pushed: ${route.settings.name}, previous: ${previousRoute?.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.info(
        'Route popped: ${route.settings.name}, previous: ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.info(
        'Route removed: ${route.settings.name}, previous: ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log.info(
        'Route replaced: ${newRoute?.settings.name}, previous: ${oldRoute?.settings.name}');
  }
}
