// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/responsive_scaffold.dart';
import 'package:sidebarx/sidebarx.dart';

class ResponsiveSidebar extends StatefulWidget {
  const ResponsiveSidebar({
    required this.controller,
    required this.destinations,
    required this.onTap,
    super.key,
    this.expandable = true,
    this.shouldExpand = false,
    this.shouldShrink = false,
    this.theme = const SidebarXTheme(
      itemTextPadding: EdgeInsets.symmetric(horizontal: 12),
      itemMargin: EdgeInsets.all(4),
      selectedItemTextPadding: EdgeInsets.symmetric(horizontal: 12),
    ),
    this.expandedWidth = 200,
    this.footerDivider,
    this.extendedTheme,
    this.headerBuilder,
    this.footerBuilder,
    this.separatorBuilder,
    this.toggleButtonBuilder,
    this.headerDivider,
    this.footerItems = const [],
    this.showToggleButton = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.collapseIcon = Icons.arrow_back_ios_new,
    this.extendIcon = Icons.arrow_forward_ios,
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
  final List<SidebarXItem> footerItems;
  final SidebarXTheme? extendedTheme;
  final Widget Function(BuildContext, bool)? headerBuilder;
  final Widget Function(BuildContext, bool)? footerBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final Widget Function(BuildContext, bool)? toggleButtonBuilder;
  final bool showToggleButton;
  final Widget? headerDivider;
  final Widget? footerDivider;
  final Duration animationDuration;
  final IconData collapseIcon;
  final IconData extendIcon;

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
    } else if (!oldWidget.shouldExpand &&
        widget.shouldExpand &&
        !oldWidget.controller.extended) {
      widget.controller.setExtended(true);
    }
  }

  @override
  Widget build(BuildContext context) {
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
