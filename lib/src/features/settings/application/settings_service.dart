import 'dart:io' as io;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/navigation_type_override.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/theme_type.dart';
import 'package:flutter_boolean_template/src/features/settings/data/repository/settings_repository.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_service.g.dart';

const String settingsBoxName = 'settingsBox';

@riverpod
class SettingsService extends _$SettingsService {
  late SettingsRepository _settingsRepository;

  @override
  Settings build() {
    _settingsRepository = ref.watch(settingsRepositoryProvider.notifier);
    return _settingsRepository.getSettings();
  }

  Future<void> resetSettings() async {
    final io.Directory? documentsDirectory =
        await $applicationDocumentsDirectory();
    await SettingsRepository.deleteBox(documentsDirectory?.path);
    await SettingsRepository.initBox(documentsDirectory?.path);
    state = _settingsRepository.getSettings();
  }

  void setPortraitNavigationTypeOverride(
    NavigationTypeOverride portraitNavigationTypeOverride,
  ) {
    final newSettings = state.copyWith(
      portraitNavigationTypeOverride: portraitNavigationTypeOverride,
    );
    state = newSettings;
    _settingsRepository.saveSettings(newSettings);
  }

  void setLandscapeNavigationTypeOverride(
    NavigationTypeOverride landscapeNavigationTypeOverride,
  ) {
    final newSettings = state.copyWith(
      landscapeNavigationTypeOverride: landscapeNavigationTypeOverride,
    );
    state = newSettings;
    _settingsRepository.saveSettings(newSettings);
  }

  bool toggleBanner() {
    final bannerEnabled = !state.bannerEnabled;
    final newSettings = state.copyWith(bannerEnabled: bannerEnabled);
    state = newSettings;
    _settingsRepository.saveSettings(newSettings);
    return bannerEnabled;
  }

  void setThemeType(ThemeType themeType) {
    final newSettings = state.copyWith(themeType: themeType);
    state = newSettings;
    _settingsRepository.saveSettings(newSettings);
  }

  void setLightTheme(FlexSchemeData lightTheme) {
    final newSettings = state.copyWith(
      lightTheme: lightTheme,
    );
    state = newSettings;
    _settingsRepository.saveSettings(newSettings);
  }

  void setDarkTheme(FlexSchemeData darkTheme) {
    final newSettings = state.copyWith(
      darkTheme: darkTheme,
    );
    state = newSettings;
    _settingsRepository.saveSettings(newSettings);
  }

  void setCustomThemes(List<FlexSchemeData> customThemes) {
    final newSettings = state.copyWith(
      customThemes: customThemes,
    );
    state = newSettings;
    _settingsRepository.saveSettings(newSettings);
  }
}
