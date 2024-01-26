import 'package:constants/constants.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/navigation_type_override.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings.g.dart';
part 'settings.mapper.dart';

@MappableClass()
@HiveType(typeId: 1)
class Settings with SettingsMappable {
  @MappableField()
  @HiveField(0, defaultValue: true)
  final bool bannerEnabled;

  @MappableField()
  @HiveField(1, defaultValue: true)
  final bool darkMode;

  @MappableField()
  @HiveField(2, defaultValue: true)
  final bool systemThemeMode;

  @MappableField()
  @HiveField(3, defaultValue: true)
  final bool confirmExit;

  @MappableField()
  @HiveField(4, defaultValue: NavigationTypeOverride.auto)
  final NavigationTypeOverride portraitNavigationTypeOverride;

  @MappableField()
  @HiveField(5, defaultValue: NavigationTypeOverride.auto)
  final NavigationTypeOverride landscapeNavigationTypeOverride;

  const Settings({
    this.bannerEnabled = true,
    this.darkMode = true,
    this.systemThemeMode = true,
    this.confirmExit = true,
    this.portraitNavigationTypeOverride = NavigationTypeOverride.auto,
    this.landscapeNavigationTypeOverride = NavigationTypeOverride.auto,
  });

  static const fromMap = SettingsMapper.fromMap;
  static const fromJson = SettingsMapper.fromJson;
}

extension SettingsExtension on Settings {
  bool get isBannerShowing => AppFlavor.isBannerEnabled && bannerEnabled;
}
