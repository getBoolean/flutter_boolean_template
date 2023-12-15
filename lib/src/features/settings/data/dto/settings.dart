import 'package:constants/constants.dart';
import 'package:dart_mappable/dart_mappable.dart';
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

  const Settings({
    this.bannerEnabled = true,
    this.darkMode = true,
    this.systemThemeMode = true,
  });

  static const fromMap = SettingsMapper.fromMap;
  static const fromJson = SettingsMapper.fromJson;
}

extension SettingsExtension on Settings {
  bool get isBannerShowing => AppFlavor.isBannerEnabled && bannerEnabled;
}
