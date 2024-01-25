import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_boolean_template/src/routing/data/navigation_type.dart';
import 'package:hive_flutter/adapters.dart';

part 'navigation_type_override.g.dart';
part 'navigation_type_override.mapper.dart';

@MappableEnum()
@HiveType(typeId: 2)
enum NavigationTypeOverride {
  @HiveField(0)
  auto('Auto'),
  @HiveField(1)
  bottom('Bottom Bar'),
  @HiveField(2)
  rail('Rail'),
  @HiveField(3)
  drawer('Drawer'),
  @HiveField(4)
  expandedSidebar('Expanded Sidebar'),
  @HiveField(5)
  top('Top Bar');

  const NavigationTypeOverride(this.humanName);

  final String humanName;
}

extension NavigationTypeOverrideConverter on NavigationTypeOverride {
  /// Converts the [NavigationTypeOverride] to a [NavigationType]
  ///
  /// [NavigationTypeOverride.auto] will be converted to [NavigationType.bottom]
  NavigationType get navigationType => switch (this) {
        NavigationTypeOverride.auto => NavigationType.bottom,
        NavigationTypeOverride.bottom => NavigationType.bottom,
        NavigationTypeOverride.rail => NavigationType.rail,
        NavigationTypeOverride.drawer => NavigationType.drawer,
        NavigationTypeOverride.expandedSidebar =>
          NavigationType.expandedSidebar,
        NavigationTypeOverride.top => NavigationType.top,
      };
}
