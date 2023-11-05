import 'package:constants/flavor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/features/settings/data/repository/settings_provider.dart';
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
    final settings = ref.watch(appSettingsProvider);
    final developerSettings = _buildDeveloperSettings(settings: settings);
    return SettingsList(
      platform: DevicePlatform.android,
      sections: [
        if (developerSettings.isNotEmpty)
          SettingsSection(
            title: const Text('Developer'),
            tiles: developerSettings,
          ),
      ],
    );
  }

  List<SettingsTile> _buildDeveloperSettings({required Settings settings}) {
    return <SettingsTile>[
      if (AppFlavor.isBannerEnabled)
        SettingsTile.switchTile(
          onToggle: (value) async {
            ref.read(appSettingsProvider.notifier).toggleBanner();
          },
          initialValue: settings.bannerEnabled,
          leading: const Icon(Icons.bug_report),
          title: const Text('Enable banner'),
        ),
    ];
  }
}
