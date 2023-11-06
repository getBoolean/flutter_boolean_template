import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository.g.dart';

const String settingsBoxName = 'settingsBox';

@riverpod
class SettingsRepository extends _$SettingsRepository {
  @override
  Settings build() {
    final settings = getSettings();
    return settings ?? const Settings();
  }

  void saveSettings(Settings settings) {
    Hive.box<Settings>(settingsBoxName).put('settings', settings);
  }

  Settings? getSettings() {
    final settingsBox = Hive.box<Settings>(settingsBoxName);
    final settingsJson = settingsBox.get('settings');
    return settingsJson;
  }
}
