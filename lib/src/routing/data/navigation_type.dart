import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/routing/ui/widgets/responsive_sidebar.dart';

/// The navigation mechanism to configure the [Scaffold] with.
enum NavigationType {
  /// Used to configure a [Scaffold] with a [NavigationBar].
  bottom,

  /// Used to configure a [Scaffold] with a [NavigationRail].
  rail,

  /// Used to configure a [Scaffold] with a modal [Drawer].
  drawer,

  /// Used to configure a [Scaffold] with an open [ResponsiveSidebar].
  expandedSidebar,

  /// Used to configure a [Scaffold] with a [TabBar]
  top;

  bool get isSidebar {
    return this == NavigationType.expandedSidebar ||
        this == NavigationType.rail;
  }
}
