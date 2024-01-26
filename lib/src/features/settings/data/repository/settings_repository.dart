import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository.g.dart';

const String _settingsBoxName = 'settingsBox';

@riverpod
class SettingsRepository extends _$SettingsRepository {
  static Future<void> initBox() async =>
      await Hive.openBox<Settings>(_settingsBoxName);

  @override
  Settings build() {
    return getSettings();
  }

  void saveSettings(Settings settings) {
    Hive.box<Settings>(_settingsBoxName).put('settings', settings);
  }

  Settings getSettings() {
    return Hive.box<Settings>(_settingsBoxName).get('settings') ??
        const Settings();
  }
}
