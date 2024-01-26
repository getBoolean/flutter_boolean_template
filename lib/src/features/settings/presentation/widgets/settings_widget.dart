import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/navigation_type_override.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/extensions.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsWidget extends StatefulHookConsumerWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  ConsumerState<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends ConsumerState<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsServiceProvider);
    final developerSettings = _buildDeveloperSettings(settings: settings);
    final theme = Theme.of(context);
    return SettingsList(
      lightTheme: SettingsThemeData(
        settingsListBackground: theme.colorScheme.background,
        settingsSectionBackground: theme.colorScheme.background,
        tileHighlightColor: theme.highlightColor,
      ),
      darkTheme: SettingsThemeData(
        settingsListBackground: theme.colorScheme.background,
        settingsSectionBackground: theme.colorScheme.background,
        tileHighlightColor: theme.highlightColor,
      ),
      brightness: theme.brightness,
      platform: DevicePlatform.android,
      sections: [
        if (developerSettings.isNotEmpty)
          SettingsSection(
            title: const Text('Developer'),
            tiles: developerSettings,
          ),
        SettingsSection(
          title: const Text('Appearance'),
          tiles: [
            SettingsTile.switchTile(
              title: const Text('Use device theme'),
              initialValue: settings.systemThemeMode,
              onToggle: (value) async {
                ref
                    .read(settingsServiceProvider.notifier)
                    .toggleSystemThemeMode();
              },
            ),
            SettingsTile.switchTile(
              title: const Text('Dark theme'),
              initialValue: settings.darkMode,
              enabled: !settings.systemThemeMode,
              onToggle: (value) async {
                ref.read(settingsServiceProvider.notifier).toggleDarkMode();
              },
            ),
            SettingsTile.navigation(
              title: const Text('Portrait Navigation'),
              value: Text(settings.portraitNavigationTypeOverride.humanName),
              onPressed: (context) async {
                final navigationTypeOverride = await context.showOptionsMenu<
                    NavigationTypeOverride, NavigationTypeOverride>(
                  title: 'Navigation',
                  current: settings.portraitNavigationTypeOverride,
                  options: NavigationTypeOverride.values,
                  itemTitleBuilder: (context, option) => option.humanName,
                );
                if (navigationTypeOverride != null) {
                  ref
                      .read(settingsServiceProvider.notifier)
                      .setPortraitNavigationTypeOverride(
                        navigationTypeOverride,
                      );
                }
              },
            ),
            SettingsTile.navigation(
              title: const Text('Landscape Navigation'),
              value: Text(settings.landscapeNavigationTypeOverride.humanName),
              onPressed: (context) async {
                final navigationTypeOverride = await context.showOptionsMenu<
                    NavigationTypeOverride, NavigationTypeOverride>(
                  title: 'Navigation',
                  current: settings.landscapeNavigationTypeOverride,
                  options: NavigationTypeOverride.values,
                  itemTitleBuilder: (context, option) => option.humanName,
                );
                if (navigationTypeOverride != null) {
                  ref
                      .read(settingsServiceProvider.notifier)
                      .setLandscapeNavigationTypeOverride(
                        navigationTypeOverride,
                      );
                }
              },
            ),
          ],
        ),
        SettingsSection(
          tiles: [
            SettingsTile(
              title: const Text('Reset settings'),
              leading: const Icon(Icons.restore),
              onPressed: (context) async {
                await showAdaptiveDialog<dynamic>(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: const Text('Reset settings'),
                      content: const Text(
                        'Are you sure you want to reset your settings?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(settingsServiceProvider.notifier)
                                .resetSettings();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  List<SettingsTile> _buildDeveloperSettings({required Settings settings}) {
    return <SettingsTile>[
      if (AppFlavor.isBannerEnabled)
        SettingsTile.switchTile(
          onToggle: (value) async {
            ref.read(settingsServiceProvider.notifier).toggleBanner();
          },
          initialValue: settings.bannerEnabled,
          leading: const Icon(Icons.bug_report),
          title: const Text('Enable banner'),
        ),
    ];
  }
}
