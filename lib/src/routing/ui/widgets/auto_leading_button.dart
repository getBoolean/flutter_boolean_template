import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// AppBar Leading button types
enum LeadingType {
  /// Whether to show a back button
  back,

  /// Whether to show a close button
  close,

  /// Whether to show a drawer toggle
  drawer,

  /// Whether to show no leading at all
  noLeading;

  /// Helper to check if this instance is [back]
  bool get isBack => this == back;

  /// Helper to check if this instance is [close]
  bool get isClose => this == close;

  /// Helper to check if this instance is [drawer]
  bool get isDrawer => this == drawer;

  /// Helper to check if this instance is [noLeading]
  bool get isNoLeading => this == noLeading;
}

/// Signature function to customize the
/// build of a leading button
typedef AutoLeadingButtonBuilder = Widget Function(
  BuildContext context,
  LeadingType leadingType,
  VoidCallback? action, // could be popTop, openDrawer or null
);

/// An GoRouter replacement of appBar aut-leading-button
///
/// Unlike the default [BackButton] this button will always
/// the top-most route in the whole hierarchy not only current-stack
///
/// meant to be used with AppBar -> AppBar(leading: AutoLeadingButton())
///
/// e.g if we have such hierarchy
/// - page1
/// - page2
///     - sub-page1
///     - sub-page2
/// and Page2 has an  AutoLeadingButton(), clicking
/// it will pop sub-page2 then page2
///
class AutoLeadingButton extends ConsumerStatefulWidget {
  /// The color of [BackButton] and [CloseButton]
  final Color? color;

  /// Clients can use this builder to customize
  /// the looks and feels of their leading buttons
  final AutoLeadingButtonBuilder? builder;

  final Duration transitionDuration;

  /// Whether to use location only to determine
  /// if the leading button should be shown
  ///
  /// If false, the button will be shown if
  /// - the router delegate can go back (location is not the first location)
  /// - the router delegate can pop
  final bool useLocationOnly;

  /// Default constructor
  const AutoLeadingButton({
    super.key,
    this.color,
    this.builder,
    this.transitionDuration = const Duration(milliseconds: 150),
    this.useLocationOnly = false,
  }) : assert(
          color == null || builder == null,
          'Cannot use both color and builder',
        );

  bool willShowButton(BuildContext context) {
    final router = GoRouter.of(context);
    final canPop = router.canGoBack() || router.canPop();
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    return canPop || (scaffold?.hasDrawer ?? false);
  }

  @override
  ConsumerState<AutoLeadingButton> createState() => _AutoLeadingButtonState();
}

class _AutoLeadingButtonState extends ConsumerState<AutoLeadingButton> {
  late final GoRouterDelegate _goRouterDelegate;

  @override
  void initState() {
    super.initState();
    _goRouterDelegate = GoRouter.of(context).routerDelegate;
    _goRouterDelegate.addListener(_handleRebuild);
  }

  @override
  void dispose() {
    super.dispose();
    _goRouterDelegate.removeListener(_handleRebuild);
  }

  @override
  Widget build(BuildContext context) {
    final Widget button;
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final router = ref.watch(routerProvider);
    final canPop =
        router.canGoBack() || (!widget.useLocationOnly && router.canPop());
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    if (canPop) {
      final bool useCloseButton =
          parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
      void pop() {
        final router = ref.read(routerProvider);
        if (router.canGoBack()) {
          router.goBack();
        } else if (router.canPop()) {
          router.pop();
        }
      }

      if (widget.builder != null) {
        return widget.builder!(
          context,
          useCloseButton ? LeadingType.close : LeadingType.back,
          pop,
        );
      }
      button = useCloseButton
          ? CloseButton(
              color: widget.color,
              style: IconButtonTheme.of(context).style,
              onPressed: pop,
            )
          : BackButton(
              color: widget.color,
              style: IconButtonTheme.of(context).style,
              onPressed: pop,
            );
    } else if (scaffold?.hasDrawer ?? false) {
      if (widget.builder != null) {
        return widget.builder!(
          context,
          LeadingType.drawer,
          () => _handleDrawerButton(context),
        );
      }
      button = IconButton(
        icon: const Icon(Icons.menu),
        iconSize: Theme.of(context).iconTheme.size ?? 24,
        onPressed: () => _handleDrawerButton(context),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        style: IconButtonTheme.of(context).style,
      );
    } else if (widget.builder != null) {
      button = widget.builder!(context, LeadingType.noLeading, null);
    } else {
      button = const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: widget.transitionDuration,
      child: button,
    );
  }

  void _handleRebuild() {
    setState(() {});
  }
}

void _handleDrawerButton(BuildContext context) {
  Scaffold.of(context).openDrawer();
}
