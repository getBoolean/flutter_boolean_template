import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/human_name_enum.dart';
import 'package:flutter_boolean_template/src/routing/data/navigation_type.dart';
import 'package:hive_flutter/adapters.dart';

part 'navigation_type_override.g.dart';
part 'navigation_type_override.mapper.dart';

@MappableEnum()
@HiveType(typeId: 2)
enum NavigationTypeOverride implements HumanReadableEnum {
  @HiveField(0)
  auto('Auto'),
  @HiveField(1)
  bottom('Bottom Bar'),
  @HiveField(3)
  drawer('Drawer'),
  @HiveField(4)
  sidebar('Sidebar'),
  @HiveField(5)
  top('Top Bar');

  const NavigationTypeOverride(this.humanName);

  @override
  final String humanName;

  bool get isAuto => this == NavigationTypeOverride.auto;
}

extension NavigationTypeOverrideConverter on NavigationTypeOverride {
  /// Converts the [NavigationTypeOverride] to a [NavigationType]
  ///
  /// [NavigationTypeOverride.auto] will be converted to [NavigationType.bottom]
  NavigationType get navigationType => switch (this) {
        NavigationTypeOverride.auto => NavigationType.bottom,
        NavigationTypeOverride.bottom => NavigationType.bottom,
        NavigationTypeOverride.drawer => NavigationType.drawer,
        NavigationTypeOverride.sidebar => NavigationType.sidebar,
        NavigationTypeOverride.top => NavigationType.top,
      };
}
