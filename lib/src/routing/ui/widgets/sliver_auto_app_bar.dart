import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/auto_adaptive_router_scaffold.dart';

/// An AppBar that automatically adapts to the navigation type of the scaffold.
///
/// If the navigation type is [NavigationType.top] or [NavigationType.drawer],
/// this app bar will be hidden.
///
/// This widget must be a descendant of [AutoAdaptiveRouterScaffold].
class SliverAutoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SliverAutoAppBar({super.key, this.title, this.navigationTypeResolver});

  final Widget? title;

  /// Determines the navigation type that the scaffold uses.
  final NavigationTypeResolver? navigationTypeResolver;

  @override
  State<SliverAutoAppBar> createState() => _SliverAutoAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SliverAutoAppBarState extends State<SliverAutoAppBar> {
  @override
  Widget build(BuildContext context) {
    final destinationScaffold = AutoAdaptiveRouterScaffold.of(context);
    final NavigationTypeResolver navigationTypeResolver =
        destinationScaffold.navigationTypeResolver ??
            defaultNavigationTypeResolver;
    final navigationType = navigationTypeResolver(context);
    final tabsRouter = AutoTabsRouter.of(context, watch: true);
    return switch (navigationType) {
      NavigationType.top ||
      NavigationType.drawer =>
        const SliverToBoxAdapter(child: SizedBox.shrink()),
      _ => SliverAppBar(
          title: widget.title ??
              Text(
                tabsRouter.topRoute.title(context),
              ),
          leading: const AutoLeadingButton(),
        ),
    };
  }
}
