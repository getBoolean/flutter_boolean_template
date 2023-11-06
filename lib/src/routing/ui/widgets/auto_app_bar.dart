import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_adaptive_router_scaffold.dart';

/// An AppBar that automatically adapts to the navigation type of the scaffold.
///
/// If the navigation type is [NavigationType.top] or [NavigationType.drawer],
/// the app bar will be hidden.
///
/// If the navigation type is [NavigationType.rail], the app bar will have a
/// leading width of 72.0 instead of the default 56.0.
///
/// This widget must be a descendant of [AutoAdaptiveRouterScaffold].
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
    final destinationScaffold = AutoAdaptiveRouterScaffold.of(context);
    final NavigationTypeResolver navigationTypeResolver =
        destinationScaffold.navigationTypeResolver ??
            defaultNavigationTypeResolver;
    final navigationType = navigationTypeResolver(context);
    final tabsRouter = AutoTabsRouter.of(context, watch: true);
    return switch (navigationType) {
      NavigationType.top || NavigationType.drawer => const SizedBox.shrink(),
      _ => AppBar(
          title: widget.title ??
              Text(
                destinationScaffold.destinations[tabsRouter.activeIndex].title,
              ),
          leading: const AutoLeadingButton(),
          leadingWidth: navigationType == NavigationType.rail ? 72.0 : 56.0,
        ),
    };
  }
}
