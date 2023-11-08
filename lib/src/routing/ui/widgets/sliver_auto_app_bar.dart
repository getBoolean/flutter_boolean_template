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
  const SliverAutoAppBar({
    super.key,
    this.title,
    this.navigationTypeResolver,
    this.builder,
  });

  final Widget? title;

  /// Determines the navigation type that the scaffold uses.
  final NavigationTypeResolver? navigationTypeResolver;

  /// Custom [SliverAppBar] builder
  ///
  /// A sliver must be returned from this builder.
  final Widget Function(BuildContext context, RouteData routeData)? builder;

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
    final routeData = RouteData.of(context);
    return switch (navigationType) {
      NavigationType.top => const SliverToBoxAdapter(child: SizedBox.shrink()),
      _ => widget.builder?.call(context, routeData) ??
          SliverAppBar(
            title: widget.title ?? Text(routeData.title(context)),
            leading: const AutoLeadingButton(),
          ),
    };
  }
}
