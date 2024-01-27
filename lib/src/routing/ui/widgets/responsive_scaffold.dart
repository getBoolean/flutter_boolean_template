import 'dart:math' as math;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/common_widgets/constrained_scrollable_child.dart';
import 'package:flutter_boolean_template/src/routing/data/navigation_type.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_leading_button.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/responsive_sidebar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:log/log.dart';
import 'package:sidebarx/sidebarx.dart';

typedef NavigationTypeResolver = NavigationType Function(BuildContext context);

typedef GoToIndexCallback = void Function(
  int newIndex, {
  bool initialLocation,
});

class ResponsiveScaffold extends StatefulHookWidget {
  const ResponsiveScaffold({
    required this.destinations,
    required this.currentIndex,
    required this.title,
    required this.child,
    required this.goToIndex,
    super.key,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionReverseDuration = Duration.zero,
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
    this.drawerWidth = 200,
    this.drawerHeader,
    this.drawerFooter,
    this.includeBaseDestinationsInMenu = true,
    this.bottomNavigationOverflow = 5,
    this.railDestinationsOverflow = 7,
    this.topBarStart,
    this.topBarEnd,
    this.isTabBarScrollable = true,
    this.tabAlignment = TabAlignment.start,
    this.divider,
    this.leadingButtonBuilder,
    this.buildTopBarTabBar,
    this.buildBottomNavigationBar,
    this.buildDrawer,
    this.buildSidebar,
    this.buildDismissableSliverAppBar,
    this.buildTopBar,
    this.logo,
  });

  static ResponsiveScaffold of(BuildContext context) {
    final scaffold =
        context.findAncestorWidgetOfExactType<ResponsiveScaffold>();
    assert(
      scaffold != null,
      'No ResponsiveScaffold found in context. Wrap your app in an ResponsiveScaffold to fix this error.',
    );
    return scaffold!;
  }

  final int currentIndex;

  final GoToIndexCallback goToIndex;

  final String title;

  final Widget child;

  /// The index into [destinations] for the current selected
  /// [RouterDestination].
  final List<RouterDestination> destinations;

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

  final Widget? logo;

  final double drawerWidth;

  /// The leading item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no header.
  final Widget? drawerHeader;

  /// The footer item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no footer.
  final Widget? drawerFooter;

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

  final Duration transitionDuration;

  final Duration transitionReverseDuration;

  final Widget Function(BuildContext context)? leadingButtonBuilder;

  /// Custom builder for [NavigationType.top]'s [TabBar]
  ///
  /// If not null, then [isTabBarScrollable], and [tabAlignment] are ignored for this type.
  final TabBar Function(
    BuildContext context,
    TabController controller,
    void Function(int index) setPage,
  )? buildTopBarTabBar;

  /// Custom builder for [NavigationType.top]
  final PreferredSize Function(
    BuildContext context,
    TabBar tabBar,
    void Function(int index) setPage,
  )? buildTopBar;

  /// Custom builder for [NavigationType.bottom]
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    List<RouterDestination> bottomDestinations,
    void Function(int index) setPage,
  )? buildBottomNavigationBar;

  /// Custom builder for [NavigationType.drawer]
  ///
  /// If not null, then [drawerHeader] and [drawerFooter] are ignored for this type.
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    void Function(int index) setPage,
  )? buildDrawer;

  /// Custom builder for [NavigationType.expandedSidebar]
  /// and [NavigationType.rail]
  ///
  /// If not null, then [drawerHeader] and [drawerFooter] are ignored for this type.
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    void Function(int index) setPage,
    NavigationType navigationType,
  )? buildSidebar;

  /// Custom [SliverAppBar] builder for [NavigationType.drawer] and [NavigationType.bottom]
  ///
  /// A sliver must be returned from this builder.
  final Widget Function(
    BuildContext context,
    NavigationType navigationType,
    String? title,
  )? buildDismissableSliverAppBar;

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _key = GlobalKey<ScaffoldState>();

  late SidebarXController _sidebarController;
  late SidebarXController _drawerController;
  @override
  void initState() {
    super.initState();

    _sidebarController = SidebarXController(
      selectedIndex: widget.currentIndex,
      extended: true,
    );

    _drawerController = SidebarXController(
      selectedIndex: widget.currentIndex,
      extended: true,
    );
  }

  @override
  void dispose() {
    _sidebarController.dispose();
    _drawerController.dispose();
    super.dispose();
  }

  NavigationType getNavigationType() =>
      (widget.navigationTypeResolver ?? defaultNavigationTypeResolver)(context);

  @override
  Widget build(BuildContext context) {
    _tabController = useTabController(
      initialLength: widget.destinations.length,
      initialIndex: widget.currentIndex,
    );
    final navigationType = getNavigationType();
    final hasDrawer = navigationType == NavigationType.drawer;
    final hasBottomNavigationBar = navigationType == NavigationType.bottom;

    final bottomDestinations = widget.destinations.sublist(
      0,
      math.min(widget.destinations.length, widget.bottomNavigationOverflow),
    );

    final buildBottomNavigationBar =
        widget.buildBottomNavigationBar ?? _defaultBottomNavigationBarBuilder;
    final selectedIndex = widget.currentIndex;
    final bottomNavigationBar = buildBottomNavigationBar(
      context,
      selectedIndex,
      bottomDestinations,
      _setPage,
    );

    final buildDrawer = widget.buildDrawer ?? _defaultBuildDrawer;
    final drawer = buildDrawer(
      context,
      selectedIndex,
      (index) {
        _key.currentState?.closeDrawer();
        _setPage(index);
      },
    );

    final buildSidebar = widget.buildSidebar ?? _defaultBuildSidebar;
    final sidebar = buildSidebar(
      context,
      selectedIndex,
      _setPage,
      navigationType,
    );

    final buildSliverAppBar = widget.buildDismissableSliverAppBar ??
        _defaultBuildDismissableSliverAppBar;

    final buildTabBar = widget.buildTopBarTabBar ?? _defaultTabBarBuilder;

    final buildTopBar = widget.buildTopBar ?? _defaultTopBarBuilder;
    return Scaffold(
      key: _key,
      appBar: navigationType == NavigationType.top
          ? buildTopBar(
              context,
              buildTabBar(context, _tabController, _setPage),
              _setPage,
            )
          : null,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            if (navigationType != NavigationType.top)
              buildSliverAppBar(
                context,
                navigationType,
                widget.title,
              ),
          ];
        },
        body: Row(
          children: [
            AnimatedSwitcher(
              duration: widget.transitionDuration,
              reverseDuration: widget.transitionReverseDuration,
              child: navigationType == NavigationType.expandedSidebar ||
                      navigationType == NavigationType.rail
                  ? sidebar
                  : null,
            ),
            widget.divider ?? vdivider,
            Expanded(child: widget.child),
          ],
        ),
      ),
      drawer: hasDrawer ? drawer : null,
      bottomNavigationBar: hasBottomNavigationBar ? bottomNavigationBar : null,
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
    );
  }

  void _setPage(int index) {
    final previousIndex = widget.currentIndex;
    widget.goToIndex(index, initialLocation: index == previousIndex);
    _tabController.index = index;
  }

  PreferredSize _defaultTopBarBuilder(
    BuildContext context,
    TabBar tabBar,
    void Function(int index) setPage,
  ) {
    return PreferredSize(
      preferredSize: tabBar.preferredSize,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ConstrainedScrollableChild(
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
          const Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: AutoLeadingButton(showDisabled: false),
          ),
        ],
      ),
    );
  }

  Widget _defaultBuildSidebar(
    BuildContext context,
    int selectedIndex,
    void Function(int index) setPage,
    NavigationType navigationType,
  ) {
    return _StyledResponsiveSidebar(
      key: const Key('responsive-sidebarx'),
      controller: _sidebarController,
      destinations: widget.destinations,
      onTap: _setPage,
      expandable: true,
      shouldExpand: navigationType.isSidebar
          ? navigationType == NavigationType.expandedSidebar
          : null,
      shouldShrink: navigationType.isSidebar
          ? navigationType == NavigationType.rail
          : null,
      expandedWidth: widget.drawerWidth,
      expandedHeader: widget.drawerHeader,
      collapseHeader: widget.logo,
      transitionDuration: widget.transitionDuration,
      reverseTransitionDuration: widget.transitionReverseDuration,
    );
  }

  Widget _defaultBuildDrawer(
    BuildContext context,
    int selectedIndex,
    void Function(int index) setPage,
  ) {
    final theme = Theme.of(context);
    return Drawer(
      elevation: 0.0,
      width: widget.drawerWidth,
      child: Column(
        children: [
          if (widget.drawerHeader != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.drawerHeader,
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
    TabController controller,
    void Function(int index) setPage,
  ) {
    return TabBar(
      onTap: setPage,
      isScrollable: widget.isTabBarScrollable,
      tabAlignment: widget.tabAlignment,
      controller: controller,
      tabs: <Tab>[
        for (final destination in widget.destinations)
          Tab(child: Text(destination.title)),
      ],
    );
  }

  Widget _defaultBuildDismissableSliverAppBar(
    BuildContext context,
    NavigationType navigationType,
    String? title,
  ) {
    return switch (navigationType) {
      NavigationType.bottom => SliverAppBar(
          centerTitle: true,
          leading: const AutoLeadingButton(),
          title: title == null ? null : Text(title),
          automaticallyImplyLeading: false,
          expandedHeight: 50,
          floating: true,
          snap: true,
        ),
      NavigationType.drawer => SliverAppBar(
          centerTitle: true,
          leading: const AutoLeadingButton(),
          title: title == null ? null : Text(title),
          automaticallyImplyLeading: false,
          expandedHeight: 50,
          floating: true,
          snap: true,
        ),
      _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
    };
  }
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
    return NavigationType.expandedSidebar;
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
      'New route pushed: ${route.settings.name}, previous: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.info(
      'Route popped: ${route.settings.name}, previous: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log.info(
      'Route removed: ${route.settings.name}, previous: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log.info(
      'Route replaced: ${newRoute?.settings.name}, previous: ${oldRoute?.settings.name}',
    );
  }
}

class _StyledResponsiveSidebar extends StatelessWidget {
  const _StyledResponsiveSidebar({
    required this.destinations,
    required this.controller,
    required this.expandable,
    required this.shouldExpand,
    required this.shouldShrink,
    required this.onTap,
    required this.expandedWidth,
    required this.expandedHeader,
    required this.collapseHeader,
    required this.transitionDuration,
    required this.reverseTransitionDuration,
    super.key,
  });

  /// The index into [destinations] for the current selected
  /// [RouterDestination].
  final List<RouterDestination> destinations;
  final SidebarXController controller;

  final bool expandable;
  final bool? shouldExpand;
  final bool? shouldShrink;
  final double expandedWidth;

  final Widget? expandedHeader;
  final Widget? collapseHeader;

  final Duration? transitionDuration;
  final Duration? reverseTransitionDuration;

  /// Callback to set the current page in the navigator
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ResponsiveSidebar(
      controller: controller,
      destinations: destinations,
      onTap: onTap,
      shouldExpand: shouldExpand,
      shouldShrink: shouldShrink,
      expandable: expandable,
      expandedWidth: expandedWidth,
      footerDivider: hdivider,
      headerBuilder: (context, isExpanded) {
        final Widget? widget = isExpanded ? expandedHeader : collapseHeader;
        return widget == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedSwitcher(
                  duration:
                      transitionDuration ?? const Duration(milliseconds: 300),
                  reverseDuration: reverseTransitionDuration,
                  child: widget,
                ),
              );
      },
      separatorBuilder: (_, __) => const SizedBox.shrink(),
      theme: SidebarXTheme(
        itemPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        selectedItemPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        itemMargin: const EdgeInsets.symmetric(vertical: 1),
        selectedItemMargin: const EdgeInsets.symmetric(vertical: 1),
        itemTextPadding: const EdgeInsets.symmetric(horizontal: 14),
        selectedItemTextPadding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: theme.canvasColor,
        ),
        hoverColor: theme.hoverColor,
        selectedHoverColor: theme.hoverColor,
        focusColor: theme.focusColor,
        selectedFocusColor: theme.focusColor,
        highlightColor: theme.highlightColor,
        selectedHighlightColor: theme.highlightColor,
        splashColor: theme.splashColor,
        selectedSplashColor: theme.splashColor,
        hoverTextStyle: theme.textTheme.bodyLarge
            ?.copyWith(color: theme.colorScheme.onSurface),
        textStyle: theme.textTheme.bodyLarge
            ?.copyWith(color: theme.colorScheme.onSurface),
        selectedTextStyle: theme.textTheme.bodyLarge
            ?.copyWith(color: theme.colorScheme.secondary),
        itemDecoration: BoxDecoration(
          border: Border.all(color: theme.canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          border: Border.all(color: theme.canvasColor),
        ),
        iconTheme: IconTheme.of(context)
            .copyWith(color: theme.colorScheme.onSurfaceVariant),
        selectedIconTheme: IconTheme.of(context).copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
