import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

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
    return SettingsList(
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
