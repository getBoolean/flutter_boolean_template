import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/materialkage:go_router/go_router.dart';
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

  /// Hides the button when the leading type is [LeadingType.noLeading]
  ///
  /// Defaults to `false`
  final bool? showDisabled;

  /// Default constructor
  const AutoLeadingButton({
    super.key,
    this.color,
    this.builder,
    this.showDisabled,
  })  : assert(color == null || builder == null,
            'Cannot use both color and builder'),
        assert(showDisabled == null || builder == null,
            'Cannot use both hideDisabled and builder');

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
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final router = ref.watch(routerProvider);
    // final locationHistoryNotifier = ref.watch(locationHistoryProvider.notifier);
    final canPop = /*locationHistoryNotifier.canGoBack() ||*/ router.canPop();
    if (canPop) {
      final bool useCloseButton =
          parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
      void pop() {
        final bool canPop = router.canPop();
        if (canPop) {
          router.pop();
        }
        // else {
        //   locationHistoryNotifier.goBack();
        // }
      }

      if (widget.builder != null) {
        return widget.builder!(
          context,
          useCloseButton ? LeadingType.close : LeadingType.back,
          pop,
        );
      }
      return useCloseButton
          ? CloseButton(
              color: widget.color,
              onPressed: pop,
            )
          : BackButton(
              color: widget.color,
              onPressed: pop,
            );
    }
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    if (scaffold?.hasDrawer ?? false) {
      if (widget.builder != null) {
        return widget.builder!(
          context,
          LeadingType.drawer,
          () => _handleDrawerButton(context),
        );
      }
      return IconButton(
        icon: const Icon(Icons.menu),
        iconSize: Theme.of(context).iconTheme.size ?? 24,
        onPressed: () => _handleDrawerButton(context),
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }

    if (widget.builder != null) {
      return widget.builder!(context, LeadingType.noLeading, null);
    }

    final showDisabled = widget.showDisabled ?? false;
    if (!showDisabled) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: const BackButtonIcon(),
      iconSize: context.themes.icon.size ?? 24,
      onPressed: null,
    );
  }

  void _handleRebuild() {
    setState(() {});
  }
}

void _handleDrawerButton(BuildContext context) {
  Scaffold.of(context).openDrawer();
}
