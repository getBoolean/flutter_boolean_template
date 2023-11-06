import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

const String settingsBoxName = 'settingsBox';

@riverpod
class AppSettings extends _$AppSettings {
  @override
  Settings build() {
    final settings = _getSettings();
    return settings ?? const Settings();
  }

  void toggleBanner() {
    final bannerEnabled = state.bannerEnabled;
    final newSettings = state.copyWith(bannerEnabled: !bannerEnabled);
    state = newSettings;
    _saveSettings(newSettings);
  }

  void toggleDarkMode() {
    final darkMode = state.darkMode;
    final newSettings = state.copyWith(darkMode: !darkMode);
    state = newSettings;
    _saveSettings(newSettings);
  }

  void toggleSystemThemeMode() {
    final systemThemeMode = state.systemThemeMode;
    final newSettings = state.copyWith(systemThemeMode: !systemThemeMode);
    state = newSettings;
    _saveSettings(newSettings);
  }

  void _saveSettings(Settings settings) {
    Hive.box<Settings>(settingsBoxName).put('settings', settings);
  }

  Settings? _getSettings() {
    final settingsBox = Hive.box<Settings>(settingsBoxName);
    final settingsJson = settingsBox.get('settings');
    return settingsJson;
  }
}