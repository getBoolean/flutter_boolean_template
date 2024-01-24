// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/responsive_scaffold.dart';
import 'package:sidebarx/sidebarx.dart';

class ResponsiveSidebar extends StatefulWidget {
  const ResponsiveSidebar({
    super.key,
    required this.controller,
    required this.destinations,
    required this.onTap,
    this.expandable = true,
    this.shouldExpand = false,
    this.shouldShrink = false,
    this.theme = const SidebarXTheme(),
    this.expandedWidth = 200,
    this.footerDivider,
    this.extendedTheme,
    this.headerBuilder,
    this.footerBuilder,
    this.separatorBuilder,
    this.toggleButtonBuilder,
    this.headerDivider,
  });

  /// The index into [destinations] for the current selected
  /// [RouterDestination].
  final List<RouterDestination> destinations;
  final SidebarXController controller;

  final bool expandable;
  final bool shouldExpand;
  final bool shouldShrink;
  final SidebarXTheme theme;
  final double expandedWidth;
  final List<SidebarXItem> footerItems = const [];
  final SidebarXTheme? extendedTheme;
  final Widget Function(BuildContext, bool)? headerBuilder;
  final Widget Function(BuildContext, bool)? footerBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final Widget Function(BuildContext, bool)? toggleButtonBuilder;
  final bool showToggleButton = true;
  final Widget? headerDivider;
  final Widget? footerDivider;
  final Duration animationDuration = const Duration(milliseconds: 300);
  final IconData collapseIcon = Icons.arrow_back_ios_new;
  final IconData extendIcon = Icons.arrow_forward_ios;

  /// Callback to set the current page in the navigator
  final void Function(int index) onTap;

  @override
  State<ResponsiveSidebar> createState() => _ResponsiveSidebarState();
}

class _ResponsiveSidebarState extends State<ResponsiveSidebar> {
  @override
  void didUpdateWidget(ResponsiveSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldExpand && widget.shouldShrink) {
      return;
    }

    if (!oldWidget.shouldShrink &&
        widget.shouldShrink &&
        oldWidget.controller.extended) {
      widget.controller.setExtended(false);
    }
    if (!oldWidget.shouldExpand &&
        widget.shouldExpand &&
        !oldWidget.controller.extended) {
      widget.controller.setExtended(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // SidebarXTheme(
    //   margin: const EdgeInsets.all(10),
    //   decoration: BoxDecoration(
    //     color: canvasColor,
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   hoverColor: scaffoldBackgroundColor,
    //   textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
    //   selectedTextStyle: const TextStyle(color: Colors.white),
    //   itemTextPadding: const EdgeInsets.only(left: 30),
    //   selectedItemTextPadding: const EdgeInsets.only(left: 30),
    //   itemDecoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     border: Border.all(color: canvasColor),
    //   ),
    //   selectedItemDecoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     border: Border.all(
    //       color: actionColor.withOpacity(0.37),
    //     ),
    //     gradient: const LinearGradient(
    //       colors: [accentCanvasColor, canvasColor],
    //     ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.28),
    //         blurRadius: 30,
    //       )
    //     ],
    //   ),
    //   iconTheme: IconThemeData(
    //     color: Colors.white.withOpacity(0.7),
    //     size: 20,
    //   ),
    //   selectedIconTheme: const IconThemeData(
    //     color: Colors.white,
    //     size: 20,
    //   ),
    // ),
    return SidebarX(
      showToggleButton: widget.expandable,
      controller: widget.controller,
      theme: widget.theme,
      extendedTheme:
          (widget.extendedTheme?.mergeWith(widget.theme) ?? widget.theme)
              .copyWith(
        width: widget.expandedWidth,
      ),
      footerDivider: widget.footerDivider,
      headerBuilder: widget.headerBuilder,
      items: [
        for (final destination in widget.destinations)
          SidebarXItem(
            icon: destination.icon,
            label: destination.title,
            onTap: () => widget.onTap(
              widget.destinations.indexOf(destination),
            ),
          ),
      ],
      footerItems: widget.footerItems,
      animationDuration: widget.animationDuration,
      collapseIcon: widget.collapseIcon,
      extendIcon: widget.extendIcon,
      footerBuilder: widget.footerBuilder,
      headerDivider: widget.headerDivider,
      separatorBuilder: widget.separatorBuilder,
      toggleButtonBuilder: widget.toggleButtonBuilder,
    );
  }
}
