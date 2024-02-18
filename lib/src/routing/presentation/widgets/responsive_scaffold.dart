import 'dart:math' as math;

import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_boolean_template/src/routing/data/navigation_type.dart';
import 'package:flutter_boolean_template/src/routing/presentation/widgets/responsive_sidebar.dart';
import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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
    this.buildLogo,
    this.buildActionButton,
    this.minActionExpandedWidth = 1100,
    this.minLogoExpandedWidth = 900,
    this.minLogoCollapsedWidth = 350,
    this.divider = const VerticalDivider(width: 1.0, thickness: 1),
    this.navigationTypeResolver = defaultNavigationTypeResolver,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionReverseDuration,
    this.bottomNavigationOverflow = 5,
    this.drawerWidth = 200,
    this.scaffoldConfig = const ScaffoldConfig(),
    this.buildTobBarItem = _defaultTobBarItemBuilder,
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

  final Widget Function(
    BuildContext context,
    RouteName? topRoute,
    int index,
    // ignore: avoid_positional_boolean_parameters
    bool expanded,
  )? buildLogo;

  final double minLogoExpandedWidth;
  final double minLogoCollapsedWidth;

  final Widget Function(
    BuildContext context,
    RouteName? topRoute,
    int index,
    // ignore: avoid_positional_boolean_parameters
    bool expanded,
  )? buildActionButton;

  final double minActionExpandedWidth;

  /// The width of the drawer and expanded sidebar
  final double drawerWidth;

  /// Maximum number of items to display in [NavigationBar]
  final int bottomNavigationOverflow;

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
  final Tab Function(
    BuildContext context,
    RouterDestination destination,
  ) buildTobBarItem;

  /// Custom builder for [NavigationType.top]
  final PreferredSizeWidget Function(
    BuildContext context,
    RouteName? topRoute,
    NavigationType navigationType,
    TabBar tabBar,
    String title,
  )? buildTopBar;

  /// Custom builder for [NavigationType.bottom]
  final Widget Function(
    BuildContext context,
    RouteName? topRoute,
    int selectedIndex,
    List<RouterDestination> bottomDestinations,
    void Function(int index) setPage,
  ) buildBottomNavigationBar;

  /// Custom builder for [NavigationType.drawer]
  final Widget Function(
    BuildContext context,
    RouteName? topRoute,
    int selectedIndex,
    void Function(int index) setPage,
  )? buildDrawer;

  /// Custom builder for [NavigationType.sidebar]
  /// and [NavigationType.sidebar]
  final Widget Function(
    BuildContext context,
    RouteName? topRoute,
    int selectedIndex,
    void Function(int index) setPage,
    NavigationType navigationType,
  )? buildSidebar;

  /// Custom [SliverAppBar] builder for [NavigationType.drawer] and [NavigationType.bottom]
  ///
  /// A sliver must be returned from this builder.
  final Widget Function(
    BuildContext context,
    RouteName? topRoute,
    NavigationType navigationType,
    Widget? trailing,
    String? title,
  )? buildDismissableSliverAppBar;

  final PreferredSizeWidget Function(
    BuildContext context,
    RouteName? topRoute,
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final navigationType = widget.navigationTypeResolver(context);
    if (navigationType != NavigationType.drawer &&
        (_key.currentState?.isDrawerOpen ?? false)) {
      _key.currentState?.closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final topRoute = GoRouterState.of(context).topRoute;
    final topRouteName = topRoute == null || topRoute.name == null
        ? null
        : RouteName.values.byName(topRoute.name!);
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
      topRouteName,
      selectedIndex,
      bottomDestinations,
      _setPage,
    );

    final buildDrawer = widget.buildDrawer ?? _defaultBuildDrawer;
    final drawer = buildDrawer(
      context,
      topRouteName,
      selectedIndex,
      _setPage,
    );

    final buildSidebar = widget.buildSidebar ?? _defaultBuildSidebar;
    final sidebar = buildSidebar(
      context,
      topRouteName,
      selectedIndex,
      _setPage,
      navigationType,
    );

    final buildSliverAppBar = widget.buildDismissableSliverAppBar ??
        _defaultBuildDismissableSliverAppBar;
    final buildSidebarAppBar =
        widget.buildSidebarAppBar ?? _defaultBuildSidebarAppBar;

    final buildTopBar = widget.buildTopBar ?? _defaultBuildTopBar;
    final tabBar = TabBar(
      onTap: _setPage,
      controller: _tabController,
      tabs: <Tab>[
        for (final destination in widget.destinations)
          widget.buildTobBarItem(context, destination),
      ],
    );

    return Scaffold(
      key: _key,
      appBar: switch (navigationType) {
        NavigationType.top => buildTopBar(
            context,
            topRouteName,
            navigationType,
            tabBar,
            widget.title,
          ),
        NavigationType.sidebar => buildSidebarAppBar(
            context,
            topRouteName,
            navigationType,
            widget.title,
          ),
        _ => null,
      },
      body: SwapExpandedWidgetBuilder(
        collapsed: widget.buildActionButton
            ?.call(context, topRouteName, widget.currentIndex, false),
        expanded: widget.buildActionButton
            ?.call(context, topRouteName, widget.currentIndex, true),
        minExpandedWidth: widget.minActionExpandedWidth,
        builder: (context, action) {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                switch (navigationType) {
                  NavigationType.bottom => buildSliverAppBar(
                      context,
                      topRouteName,
                      navigationType,
                      action,
                      widget.title,
                    ),
                  NavigationType.drawer => buildSliverAppBar(
                      context,
                      topRouteName,
                      navigationType,
                      action,
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
                  child:
                      navigationType == NavigationType.sidebar ? sidebar : null,
                ),
                widget.divider,
                Expanded(child: widget.child),
              ],
            ),
          );
        },
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
    _key.currentState?.closeDrawer();
    widget.goToIndex(index, initialLocation: index == previousIndex);
    _tabController.index = index;
    _sidebarController.selectIndex(index);
  }

  PreferredSizeWidget _defaultBuildSidebarAppBar(
    BuildContext context,
    RouteName? topRoute,
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
            child: AnnotatedRegion(
              value: theme.brightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
              child: SafeArea(
                child: ResponsiveNavigationToolbar(
                  leadingButton: leadingButton,
                  middle: title != null
                      ? Text(
                          title,
                          style: theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  action: widget.buildActionButton
                      ?.call(context, topRoute, widget.currentIndex, false),
                  actionExpanded: widget.buildActionButton
                      ?.call(context, topRoute, widget.currentIndex, true),
                  willShowLeadingButton: willShowLeadingButton,
                  transitionDuration: widget.transitionDuration,
                  transitionReverseDuration: widget.transitionReverseDuration,
                  logoExpanded: widget.buildLogo
                      ?.call(context, topRoute, widget.currentIndex, true),
                  logo: widget.buildLogo
                      ?.call(context, topRoute, widget.currentIndex, false),
                  minLogoCollapsedWidth: widget.minLogoCollapsedWidth,
                  minLogoExpandedWidth: widget.minLogoExpandedWidth,
                  minActionExpandedWidth: widget.minActionExpandedWidth,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _defaultBuildTopBar(
    BuildContext context,
    RouteName? topRoute,
    NavigationType navigationType,
    TabBar tabBar,
    String title,
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
          final isRootRoute = GoRouterState.of(context).isRootRoute;
          final isMobile = $deviceType.isMobile;
          return Material(
            child: AnnotatedRegion(
              value: theme.brightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8.0),
                      child: ResponsiveNavigationToolbar(
                        leadingButton: leadingButton,
                        centerMiddle: isMobile && constraints.maxWidth < 600,
                        middle: AnimatedSwitcher(
                          duration: widget.transitionDuration,
                          reverseDuration: widget.transitionReverseDuration,
                          child: (constraints.maxWidth < 600)
                              ? AnimatedSwitcher(
                                  duration: widget.transitionDuration,
                                  reverseDuration:
                                      widget.transitionReverseDuration,
                                  child: isRootRoute
                                      ? tabBar
                                      : Text(
                                          title,
                                          style: theme.textTheme.titleMedium,
                                        ),
                                )
                              : Align(
                                  alignment: AlignmentDirectional.bottomStart,
                                  child: Row(
                                    children: [
                                      IntrinsicWidth(
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minHeight: theme.appBarTheme
                                                    .toolbarHeight ??
                                                kToolbarHeight,
                                          ),
                                          child: tabBar,
                                        ),
                                      ),
                                      if (!isRootRoute) ...[
                                        gap16,
                                        Expanded(
                                          child: Text(
                                            title,
                                            style: theme.textTheme.titleMedium,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                        ),
                        willShowLeadingButton:
                            widget.willShowLeadingButton(context),
                        transitionDuration: widget.transitionDuration,
                        transitionReverseDuration:
                            widget.transitionReverseDuration,
                        logoExpanded: isRootRoute
                            ? widget.buildLogo?.call(
                                context,
                                topRoute,
                                widget.currentIndex,
                                false,
                              )
                            : null,
                        logo: isRootRoute
                            ? widget.buildLogo?.call(
                                context,
                                topRoute,
                                widget.currentIndex,
                                false,
                              )
                            : null,
                        minLogoCollapsedWidth: widget.minLogoCollapsedWidth,
                        minLogoExpandedWidth: widget.minLogoExpandedWidth,
                        action: widget.buildActionButton?.call(
                          context,
                          topRoute,
                          widget.currentIndex,
                          false,
                        ),
                        actionExpanded: widget.buildActionButton?.call(
                          context,
                          topRoute,
                          widget.currentIndex,
                          true,
                        ),
                        minActionExpandedWidth: widget.minActionExpandedWidth,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _defaultBuildDismissableSliverAppBar(
    BuildContext context,
    RouteName? topRoute,
    NavigationType navigationType,
    Widget? trailing,
    String? title,
  ) {
    return SliverAppBar(
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          final leadingButton =
              widget.buildLeadingButton(context, navigationType);
          final willShowLeadingButton = widget.willShowLeadingButton(context);
          final logo = widget.buildLogo
              ?.call(context, topRoute, widget.currentIndex, false);
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: widget.transitionDuration,
                reverseDuration: Duration.zero,
                child: KeyedSubtree(
                  key: ValueKey('leadingButton-$willShowLeadingButton'),
                  child: leadingButton,
                ),
              ),
              if (logo != null)
                AnimatedSwitcher(
                  duration: widget.transitionDuration,
                  reverseDuration: Duration.zero,
                  child: willShowLeadingButton ? null : logo,
                ),
            ],
          );
        },
      ),
      title: AnimatedSwitcher(
        duration: widget.transitionDuration,
        reverseDuration: widget.transitionReverseDuration,
        child: title == null ? null : Text(title),
      ),
      automaticallyImplyLeading: false,
      expandedHeight: 50,
      floating: true,
      snap: true,
      actions: trailing == null ? null : [trailing],
    );
  }

  Widget _defaultBuildSidebar(
    BuildContext context,
    RouteName? topRoute,
    int selectedIndex,
    void Function(int index) setPage,
    NavigationType navigationType,
  ) {
    final bool collapsedSidebar = navigationType == NavigationType.sidebar &&
        WidthPlatformBreakpoint(end: $breakpointMediumSmall.end)
            .isActive(context);
    return _StyledResponsiveSidebar(
      controller: _sidebarController,
      destinations: widget.destinations,
      onTap: _setPage,
      expandable: true,
      expanded: navigationType.isSidebar ? !collapsedSidebar : null,
      expandedWidth: widget.drawerWidth,
      transitionDuration: widget.transitionDuration,
      reverseTransitionDuration: widget.transitionReverseDuration,
    );
  }

  Widget _defaultBuildDrawer(
    BuildContext context,
    RouteName? topRoute,
    int selectedIndex,
    void Function(int index) setPage,
  ) {
    final theme = Theme.of(context);
    final logoExpanded =
        widget.buildLogo?.call(context, topRoute, selectedIndex, true);
    return Drawer(
      elevation: 0.0,
      width: widget.drawerWidth,
      child: SafeArea(
        child: Column(
          children: [
            if (logoExpanded != null)
              Padding(
                padding: const EdgeInsetsDirectional.all(16.0),
                child: logoExpanded,
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
          ],
        ),
      ),
    );
  }
}

class ResponsiveNavigationToolbar extends StatelessWidget {
  const ResponsiveNavigationToolbar({
    required this.leadingButton,
    required this.middle,
    required this.willShowLeadingButton,
    required this.transitionDuration,
    required this.minLogoExpandedWidth,
    required this.minLogoCollapsedWidth,
    required this.minActionExpandedWidth,
    super.key,
    this.transitionReverseDuration,
    this.logo,
    this.logoExpanded,
    this.action,
    this.actionExpanded,
    this.centerMiddle = true,
  });

  final Widget leadingButton;
  final bool willShowLeadingButton;
  final Duration transitionDuration;
  final Duration? transitionReverseDuration;

  final Widget? middle;
  final Widget? logo;
  final Widget? logoExpanded;
  final Widget? action;
  final Widget? actionExpanded;

  final double minLogoExpandedWidth;
  final double minLogoCollapsedWidth;

  final double minActionExpandedWidth;

  final bool centerMiddle;

  @override
  Widget build(BuildContext context) {
    return SwapExpandedWidgetBuilder(
      collapsed: Container(
        key: const ValueKey('ResponsiveNavigationToolbar-logo'),
        child: logo,
      ),
      expanded: Container(
        key: const ValueKey('ResponsiveNavigationToolbar-logoExpanded'),
        child: logoExpanded,
      ),
      minExpandedWidth: minLogoExpandedWidth,
      minCollapsedWidth: minLogoCollapsedWidth,
      builder: (context, logo) => SwapExpandedWidgetBuilder(
        collapsed: Container(
          key: const ValueKey('ResponsiveNavigationToolbar-action'),
          child: action,
        ),
        expanded: Container(
          key: const ValueKey('ResponsiveNavigationToolbar-actionExpanded'),
          child: actionExpanded,
        ),
        minExpandedWidth: minActionExpandedWidth,
        builder: (context, action) => _buildNavigationToolbar(logo, action),
      ),
    );
  }

  NavigationToolbar _buildNavigationToolbar(Widget? logo, Widget? action) {
    return NavigationToolbar(
      trailing: AnimatedSwitcher(
        duration: transitionDuration,
        reverseDuration: Duration.zero,
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: action,
      ),
      middle: AnimatedSwitcher(
        duration: transitionDuration,
        reverseDuration: transitionReverseDuration,
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: middle,
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSize(
            alignment: AlignmentDirectional.centerStart,
            duration: transitionDuration,
            reverseDuration: transitionReverseDuration,
            curve: Curves.easeInOut,
            child: Container(
              key: ValueKey('leadingButton-$willShowLeadingButton'),
              child: leadingButton,
            ),
          ),
          AnimatedSize(
            duration: transitionDuration,
            reverseDuration: transitionReverseDuration,
            alignment: AlignmentDirectional.centerStart,
            curve: Curves.easeInOut,
            child: logo,
          ),
        ],
      ),
    );
  }
}

class SwapExpandedWidgetBuilder extends StatelessWidget {
  const SwapExpandedWidgetBuilder({
    required this.collapsed,
    required this.expanded,
    required this.builder,
    required this.minExpandedWidth,
    this.minCollapsedWidth,
    super.key,
  });

  final Widget? collapsed;
  final Widget? expanded;
  final Widget? Function(BuildContext context, Widget? action) builder;
  final double minExpandedWidth;
  final double? minCollapsedWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(
              context,
              switch (constraints) {
                BoxConstraints() when constraints.maxWidth == double.infinity =>
                  () {
                    if (kDebugMode) {
                      print(
                        'Warning(SwapExpandedWidgetBuilder): constraints.maxWidth == double.infinity',
                      );
                    }
                    return null;
                  }(),
                BoxConstraints()
                    when minCollapsedWidth != null &&
                        constraints.maxWidth < minCollapsedWidth! =>
                  null,
                BoxConstraints() when constraints.maxWidth < minExpandedWidth =>
                  collapsed,
                BoxConstraints()
                    when constraints.maxWidth >= minExpandedWidth =>
                  expanded ?? collapsed,
                BoxConstraints() => null
              },
            ) ??
            const SizedBox.shrink();
      },
    );
  }
}

Widget _defaultBottomNavigationBarBuilder(
  BuildContext context,
  RouteName? topRoute,
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

Tab _defaultTobBarItemBuilder(
  BuildContext context,
  RouterDestination destination,
) =>
    Tab(
      child: Icon(
        destination.icon,
        semanticLabel: destination.title,
      ),
    );

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
  if (defaultIsLargeScreen(context) || defaultIsMediumScreen(context)) {
    return NavigationType.sidebar;
  } else {
    return NavigationType.bottom;
  }
}

bool defaultIsLargeScreen(BuildContext context) =>
    Breakpoints.large.isActive(context);
bool defaultIsMediumScreen(BuildContext context) =>
    Breakpoints.medium.isActive(context);

class _StyledResponsiveSidebar extends StatelessWidget {
  const _StyledResponsiveSidebar({
    required this.destinations,
    required this.controller,
    required this.expandable,
    required this.expanded,
    required this.onTap,
    required this.expandedWidth,
    required this.transitionDuration,
    required this.reverseTransitionDuration,
  });

  /// The index into [destinations] for the current selected
  /// [RouterDestination].
  final List<RouterDestination> destinations;
  final SidebarXController controller;

  final bool expandable;
  final bool? expanded;
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
      expanded: expanded,
      expandable: expandable,
      expandedWidth: expandedWidth,
      footerDivider: const Divider(height: 1.0, thickness: 1),
      separatorBuilder: (_, __) => const SizedBox.shrink(),
      theme: SidebarXTheme(
        itemPadding:
            const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 12),
        selectedItemPadding:
            const EdgeInsetsDirectional.symmetric(horizontal: 15, vertical: 12),
        itemMargin: const EdgeInsetsDirectional.symmetric(vertical: 1),
        selectedItemMargin: const EdgeInsetsDirectional.symmetric(vertical: 1),
        itemTextPadding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
        selectedItemTextPadding:
            const EdgeInsetsDirectional.symmetric(horizontal: 14),
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
          // ignore: avoid_using_api
          border: Border.all(color: theme.canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          // ignore: avoid_using_api
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
