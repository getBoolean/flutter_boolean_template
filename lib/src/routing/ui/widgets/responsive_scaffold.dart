import 'dart:math' as math;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/data/navigation_type.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/responsive_sidebar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    required this.willShowLeadingButton,
    required this.buildLeadingButton,
    super.key,
    this.logoExpanded,
    this.logo,
    this.primaryAction,
    this.primaryActionExpanded,
    this.divider = const VerticalDivider(width: 1.0, thickness: 1),
    this.navigationTypeResolver = defaultNavigationTypeResolver,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionReverseDuration,
    this.bottomNavigationOverflow = 5,
    this.drawerWidth = 200,
    this.isTabBarScrollable = true,
    this.tabAlignment = TabAlignment.start,
    this.scaffoldConfig = const ScaffoldConfig(),
    this.buildTobBarItem = _defaultTabBarItemBuilder,
    this.buildBottomNavigationBar = _defaultBottomNavigationBarBuilder,
    this.buildDrawer,
    this.buildSidebar,
    this.buildDismissableSliverAppBar,
    this.buildSidebarAppBar,
    this.buildTopBar,
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

  /// Determines the navigation type that the scaffold uses.
  final NavigationTypeResolver navigationTypeResolver;

  /// A small logo to display when there is little space available
  final Widget? logo;

  /// A larger logo to display when there is more space available
  final Widget? logoExpanded;

  final Widget? primaryAction;

  final Widget? primaryActionExpanded;

  /// The width of the drawer and expanded sidebar
  final double drawerWidth;

  /// Maximum number of items to display in [NavigationBar]
  final int bottomNavigationOverflow;

  /// The alignment for the tabs in the [TabBar]
  final TabAlignment tabAlignment;

  /// Whether the [TabBar] can be scrolled horizontally.
  ///
  /// If [isTabBarScrollable] is true, then each tab is as wide as needed for its label
  /// and the entire [TabBar] is scrollable. Otherwise each tab gets an equal
  /// share of the available space.
  final bool isTabBarScrollable;

  /// The [VerticalDivider] between the [Drawer]/[ResponsiveSidebar] and the body.
  final Widget divider;

  final Duration transitionDuration;

  final Duration? transitionReverseDuration;

  /// Properties are applied to the root [Scaffold] widget.
  final ScaffoldConfig scaffoldConfig;

  final bool Function(BuildContext context) willShowLeadingButton;

  /// Custom builder for the [AppBar]'s leading button
  final Widget Function(BuildContext context, NavigationType navigationType)
      buildLeadingButton;

  /// Custom builder for [NavigationType.top]'s [Tab] item in [TabBar]
  ///
  /// If not null, then [isTabBarScrollable], and [tabAlignment] are ignored for this type.
  final Tab Function(
    BuildContext context,
    RouterDestination destination,
  ) buildTobBarItem;

  /// Custom builder for [NavigationType.top]
  final PreferredSizeWidget Function(
    BuildContext context,
    NavigationType navigationType,
    TabBar tabBar,
  )? buildTopBar;

  /// Custom builder for [NavigationType.bottom]
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    List<RouterDestination> bottomDestinations,
    void Function(int index) setPage,
  ) buildBottomNavigationBar;

  /// Custom builder for [NavigationType.drawer]
  final Widget Function(
    BuildContext context,
    int selectedIndex,
    void Function(int index) setPage,
  )? buildDrawer;

  /// Custom builder for [NavigationType.expandedSidebar]
  /// and [NavigationType.rail]
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
    Widget leading,
    String? title,
  )? buildDismissableSliverAppBar;

  final PreferredSizeWidget Function(
    BuildContext context,
    NavigationType navigationType,
    String? title,
  )? buildSidebarAppBar;

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

  @override
  Widget build(BuildContext context) {
    final selectedIndex = widget.currentIndex;
    final navigationType = widget.navigationTypeResolver(context);
    _tabController = useTabController(
      initialLength: widget.destinations.length,
      initialIndex: widget.currentIndex,
    );
    final hasDrawer = navigationType == NavigationType.drawer;
    final hasBottomNavigationBar = navigationType == NavigationType.bottom;
    final bottomDestinations = widget.destinations.sublist(
      0,
      math.min(widget.destinations.length, widget.bottomNavigationOverflow),
    );
    final bottomNavigationBar = widget.buildBottomNavigationBar(
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
    final buildSidebarAppBar =
        widget.buildSidebarAppBar ?? _defaultSidebarAppBarBuilder;

    final buildTopBar = widget.buildTopBar ?? _defaultTopBarBuilder;
    return Scaffold(
      key: _key,
      appBar: switch (navigationType) {
        NavigationType.top => buildTopBar(
            context,
            navigationType,
            TabBar(
              onTap: _setPage,
              isScrollable: widget.isTabBarScrollable,
              tabAlignment: widget.tabAlignment,
              controller: _tabController,
              tabs: <Tab>[
                for (final destination in widget.destinations)
                  widget.buildTobBarItem(context, destination),
              ],
            ),
          ),
        NavigationType.expandedSidebar ||
        NavigationType.rail =>
          buildSidebarAppBar(context, navigationType, widget.title),
        _ => null,
      },
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            switch (navigationType) {
              NavigationType.bottom => buildSliverAppBar(
                  context,
                  widget.buildLeadingButton(context, navigationType),
                  widget.title,
                ),
              NavigationType.drawer => buildSliverAppBar(
                  context,
                  widget.buildLeadingButton(context, navigationType),
                  widget.title,
                ),
              _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
            },
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
            widget.divider,
            Expanded(child: widget.child),
          ],
        ),
      ),
      drawer: hasDrawer ? drawer : null,
      bottomNavigationBar: hasBottomNavigationBar ? bottomNavigationBar : null,
      endDrawer: widget.scaffoldConfig.endDrawer,
      bottomSheet: widget.scaffoldConfig.bottomSheet,
      backgroundColor: widget.scaffoldConfig.backgroundColor,
      resizeToAvoidBottomInset: widget.scaffoldConfig.resizeToAvoidBottomInset,
      primary: widget.scaffoldConfig.primary,
      drawerDragStartBehavior: widget.scaffoldConfig.drawerDragStartBehavior,
      extendBody: widget.scaffoldConfig.extendBody,
      extendBodyBehindAppBar: widget.scaffoldConfig.extendBodyBehindAppBar,
      drawerScrimColor: widget.scaffoldConfig.drawerScrimColor,
      drawerEdgeDragWidth: widget.scaffoldConfig.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture:
          widget.scaffoldConfig.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture:
          widget.scaffoldConfig.endDrawerEnableOpenDragGesture,
    );
  }

  void _setPage(int index) {
    final previousIndex = widget.currentIndex;
    widget.goToIndex(index, initialLocation: index == previousIndex);
    _tabController.index = index;
  }

  PreferredSizeWidget _defaultSidebarAppBarBuilder(
    BuildContext context,
    NavigationType navigationType,
    String? title,
  ) {
    final theme = Theme.of(context);
    return PreferredSize(
      preferredSize:
          Size.fromHeight(theme.appBarTheme.toolbarHeight ?? kToolbarHeight),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final leadingButton =
              widget.buildLeadingButton(context, navigationType);
          final willShowLeadingButton = widget.willShowLeadingButton(context);
          return Material(
            child: ResponsiveNavigationToolbar(
              leadingButton: leadingButton,
              middle: title != null
                  ? Text(
                      title,
                      style: theme.textTheme.titleLarge,
                    )
                  : null,
              trailing: widget.primaryActionExpanded,
              willShowLeadingButton: willShowLeadingButton,
              transitionDuration: widget.transitionDuration,
              transitionReverseDuration: widget.transitionReverseDuration,
              logoExpanded: widget.logoExpanded,
              logo: widget.logo,
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _defaultTopBarBuilder(
    BuildContext context,
    NavigationType navigationType,
    TabBar tabBar,
  ) {
    return PreferredSize(
      preferredSize: tabBar.preferredSize,
      child: Builder(
        builder: (context) {
          final leadingButton =
              widget.buildLeadingButton(context, navigationType);
          final willShowLeadingButton = widget.willShowLeadingButton(context);
          return Material(
            child: ResponsiveNavigationToolbar(
              leadingButton: leadingButton,
              middle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  tabBar,
                  const Spacer(),
                ],
              ),
              trailing: widget.primaryActionExpanded,
              willShowLeadingButton: willShowLeadingButton,
              transitionDuration: widget.transitionDuration,
              transitionReverseDuration: widget.transitionReverseDuration,
              logoExpanded: widget.logoExpanded,
              logo: widget.logo,
            ),
          );
        },
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
          if (widget.logoExpanded != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.logoExpanded,
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
          if (widget.primaryActionExpanded != null)
            widget.primaryActionExpanded!,
        ],
      ),
    );
  }
}

class ResponsiveNavigationToolbar extends NavigationToolbar {
  const ResponsiveNavigationToolbar({
    required this.leadingButton,
    required super.middle,
    required this.willShowLeadingButton,
    required this.transitionDuration,
    super.key,
    this.logo,
    this.logoExpanded,
    this.transitionReverseDuration,
    super.trailing,
  });

  final Widget leadingButton;
  final bool willShowLeadingButton;
  final Duration transitionDuration;
  final Widget? logo;
  final Widget? logoExpanded;
  final Duration? transitionReverseDuration;

  @override
  Widget build(BuildContext context) {
    return LogoBuilder(
      logo: logo,
      logoExpanded: logoExpanded,
      middle: middle,
      trailing: trailing,
      builder: (constext, logo) {
        return NavigationToolbar(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: transitionDuration,
                reverseDuration: transitionReverseDuration,
                child: Padding(
                  key: ValueKey('leadingButton-$willShowLeadingButton'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: leadingButton,
                ),
              ),
              if (logo != null)
                AnimatedSwitcher(
                  duration: transitionDuration,
                  reverseDuration: transitionReverseDuration,
                  child: logo,
                ),
            ],
          ),
          middle: middle,
          trailing: trailing,
        );
      },
    );
  }
}

class LogoBuilder extends StatelessWidget {
  const LogoBuilder({
    required this.logo,
    required this.logoExpanded,
    required this.middle,
    required this.trailing,
    required this.builder,
    super.key,
  });

  final Widget? logo;
  final Widget? logoExpanded;
  final Widget? middle;
  final Widget? trailing;
  final Widget Function(BuildContext context, Widget? logo) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(
            context, constraints.maxWidth > 600 ? logoExpanded ?? logo : logo);
      },
    );
  }
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

Widget _defaultBuildDismissableSliverAppBar(
  BuildContext context,
  Widget leading,
  String? title,
) {
  return SliverAppBar(
    centerTitle: true,
    leading: leading,
    title: title == null ? null : Text(title),
    automaticallyImplyLeading: false,
    expandedHeight: 50,
    floating: true,
    snap: true,
  );
}

Tab _defaultTabBarItemBuilder(
  BuildContext context,
  RouterDestination destination,
) =>
    Tab(child: Text(destination.title));

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

class _StyledResponsiveSidebar extends StatelessWidget {
  const _StyledResponsiveSidebar({
    required this.destinations,
    required this.controller,
    required this.expandable,
    required this.shouldExpand,
    required this.shouldShrink,
    required this.onTap,
    required this.expandedWidth,
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
      footerDivider: const Divider(height: 1.0, thickness: 1),
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

/// Creates a configuration for a [Scaffold].
class ScaffoldConfig {
  /// Creates a configuration for a [Scaffold].
  const ScaffoldConfig({
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
  });

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
}
