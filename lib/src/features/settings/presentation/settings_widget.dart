import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/navigation_type_override.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
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
      ),
      darkTheme: SettingsThemeData(
        settingsListBackground: theme.colorScheme.background,
        settingsSectionBackground: theme.colorScheme.background,
      ),
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
              title: const Text('Navigation'),
              value: Text(settings.navigationTypeOverride.humanName),
              onPressed: (context) async {
                final navigationTypeOverride =
                    await showModalActionSheet<NavigationTypeOverride>(
                  context: context,
                  title: 'Navigation',
                  style: AdaptiveStyle.adaptive.effectiveStyle(theme),
                  actions: [
                    for (final navigationTypeOverride
                        in NavigationTypeOverride.values)
                      SheetAction(
                        label: navigationTypeOverride.humanName,
                        key: navigationTypeOverride,
                      ),
                  ],
                );
                if (navigationTypeOverride != null) {
                  ref
                      .read(settingsServiceProvider.notifier)
                      .setNavigationTypeOverride(navigationTypeOverride);
                }
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text('General'),
          tiles: [
            SettingsTile.switchTile(
              title: const Text('Confirm exit'),
              initialValue: settings.confirmExit,
              onToggle: (value) async {
                ref.read(settingsServiceProvider.notifier).toggleConfirmExit();
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
