import 'package:dart_mappable/dart_mappable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings.g.dart';
part 'settings.mapper.dart';

@MappableClass()
@HiveType(typeId: 1)
class Settings with SettingsMappable {
  @MappableField()
  @HiveField(0)
  final bool bannerEnabled;

  const Settings({
    this.bannerEnabled = true,
  });

  static const fromMap = SettingsMapper.fromMap;
  static const fromJson = SettingsMapper.fromJson;
}
