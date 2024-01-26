import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository.g.dart';

const String _settingsBoxName = 'settingsBox';

@riverpod
class SettingsRepository extends _$SettingsRepository {
  static Future<void> initBox(String? directory) async =>
      await Hive.openBox<Settings>(
        _settingsBoxName,
        path: directory == null
            ? null
            : path.join(directory, '.flutter_boolean_template'),
      );
  static Future<void> deleteBox(String? directory) async =>
      await Hive.deleteBoxFromDisk(
        _settingsBoxName,
        path: directory == null
            ? null
            : path.join(directory, '.flutter_boolean_template'),
      );

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
