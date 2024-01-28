import 'dart:math' as math;

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/foundation.dart';
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
    this.action,
    this.actionExpanded,
    this.minActionExpandedWidth = 1100,
    this.minActionCollapsedWidth = 300,
    this.minLogoExpandedWidth = 900,
    this.minLogoCollapsedWidth = 600,
    this.divider = const VerticalDivider(width: 1.0, thickness: 1),
    this.navigationTypeResolver = defaultNavigationTypeResolver,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.transitionReverseDuration,
    this.bottomNavigationOverflow = 5,
    this.drawerWidth = 200,
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

  final double minLogoExpandedWidth;
  final double minLogoCollapsedWidth;

  final Widget? action;

  final Widget? actionExpanded;

  final double minActionExpandedWidth;
  final double minActionCollapsedWidth;

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
    NavigationType navigationType,
    Widget? trailing,
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
        widget.buildSidebarAppBar ?? _defaultBuildSidebarAppBar;

    final buildTopBar = widget.buildTopBar ?? _defaultBuildTopBar;
    return Scaffold(
      key: _key,
      appBar: switch (navigationType) {
        NavigationType.top => buildTopBar(
            context,
            navigationType,
            TabBar(
              onTap: _setPage,
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
      body: SwapExpandedWidgetBuilder(
        collapsed: widget.action,
        expanded: widget.actionExpanded,
        minExpandedWidth: widget.minActionExpandedWidth,
        minCollapsedWidth: widget.minActionCollapsedWidth,
        builder: (context, action) {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                switch (navigationType) {
                  NavigationType.bottom => buildSliverAppBar(
                      context,
                      navigationType,
                      action,
                      widget.title,
                    ),
                  NavigationType.drawer => buildSliverAppBar(
                      context,
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
                  child: navigationType == NavigationType.expandedSidebar ||
                          navigationType == NavigationType.rail
                      ? sidebar
                      : null,
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
    widget.goToIndex(index, initialLocation: index == previousIndex);
    _tabController.index = index;
  }

  PreferredSizeWidget _defaultBuildSidebarAppBar(
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              action: widget.action,
              actionExpanded: widget.actionExpanded,
              willShowLeadingButton: willShowLeadingButton,
              transitionDuration: widget.transitionDuration,
              transitionReverseDuration: widget.transitionReverseDuration,
              logoExpanded: widget.logoExpanded,
              logo: widget.logo,
              minLogoCollapsedWidth: widget.minLogoCollapsedWidth,
              minLogoExpandedWidth: widget.minLogoExpandedWidth,
              minActionCollapsedWidth: widget.minActionCollapsedWidth,
              minActionExpandedWidth: widget.minActionExpandedWidth,
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _defaultBuildTopBar(
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
          return Material(
            child: ResponsiveNavigationToolbar(
              leadingButton: leadingButton,
              middle: Align(
                alignment: Alignment.centerLeft,
                child: IntrinsicWidth(child: tabBar),
              ),
              willShowLeadingButton: widget.willShowLeadingButton(context),
              transitionDuration: widget.transitionDuration,
              transitionReverseDuration: widget.transitionReverseDuration,
              logoExpanded: widget.logoExpanded,
              logo: widget.logo,
              minLogoCollapsedWidth: widget.minLogoCollapsedWidth,
              minLogoExpandedWidth: widget.minLogoExpandedWidth,
              action: widget.action,
              actionExpanded: widget.actionExpanded,
              minActionExpandedWidth: widget.minActionExpandedWidth,
              minActionCollapsedWidth: widget.minActionCollapsedWidth,
            ),
          );
        },
      ),
    );
  }

  Widget _defaultBuildDismissableSliverAppBar(
    BuildContext context,
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
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: widget.transitionDuration,
                reverseDuration: Duration.zero,
                child: Padding(
                  key: ValueKey('leadingButton-$willShowLeadingButton'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: leadingButton,
                ),
              ),
              if (widget.logo != null)
                AnimatedSwitcher(
                  duration: widget.transitionDuration,
                  reverseDuration: Duration.zero,
                  child: willShowLeadingButton ? null : widget.logo,
                ),
            ],
          );
        },
      ),
      title: title == null ? null : Text(title),
      automaticallyImplyLeading: false,
      expandedHeight: 50,
      floating: true,
      snap: true,
      actions: trailing == null ? null : [trailing],
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
          if (widget.actionExpanded != null) widget.actionExpanded!,
        ],
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
    required this.minActionCollapsedWidth,
    super.key,
    this.transitionReverseDuration,
    this.logo,
    this.logoExpanded,
    this.action,
    this.actionExpanded,
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
  final double minActionCollapsedWidth;

  @override
  Widget build(BuildContext context) {
    return SwapExpandedWidgetBuilder(
      collapsed: logo,
      expanded: logoExpanded,
      minExpandedWidth: minLogoExpandedWidth,
      minCollapsedWidth: minLogoCollapsedWidth,
      builder: (constext, logo) => SwapExpandedWidgetBuilder(
        collapsed: action,
        expanded: actionExpanded,
        minExpandedWidth: minActionExpandedWidth,
        minCollapsedWidth: minActionCollapsedWidth,
        builder: (context, action) => _buildNavigationToolbar(logo, action),
      ),
    );
  }

  NavigationToolbar _buildNavigationToolbar(Widget? logo, Widget? action) {
    return NavigationToolbar(
      trailing: action,
      middle: middle,
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
            ExcludeSemantics(
              child: AnimatedSwitcher(
                duration: transitionDuration,
                reverseDuration: transitionReverseDuration,
                child: logo,
              ),
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
    required this.minCollapsedWidth,
    super.key,
  });

  final Widget? collapsed;
  final Widget? expanded;
  final Widget? Function(BuildContext context, Widget? action) builder;
  final double minExpandedWidth;
  final double minCollapsedWidth;

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
                        'Warning(ExpandedWidgetBuilder): constraints.maxWidth == double.infinity',
                      );
                    }
                    return null;
                  }(),
                BoxConstraints()
                    when constraints.maxWidth < minCollapsedWidth =>
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
