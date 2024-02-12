import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/routing/router/router.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsScreen extends StatefulHookConsumerWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends ConsumerState<SettingsScreen> {
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
        SettingsSection(
          tiles: [
            SettingsTile.navigation(
              title: const Text('Appearance'),
              leading: const Icon(Icons.colorize),
              onPressed: (context) {
                context.goNamed(
                  RouteName.settingDetails.name,
                  pathParameters: {'id': 'appearance'},
                );
              },
            ),
            SettingsTile.navigation(
              title: const Text('About'),
              leading: const Icon(Icons.info),
              onPressed: (context) {
                context.goNamed(
                  RouteName.settingDetails.name,
                  pathParameters: {'id': 'about'},
                );
              },
            ),
          ],
        ),
        buildAdvancedSection(),
        if (developerSettings.isNotEmpty && !kReleaseMode)
          SettingsSection(
            title: const Text('Developer'),
            tiles: developerSettings,
          ),
      ],
    );
  }

  SettingsSection buildAdvancedSection() {
    return SettingsSection(
      title: const Text('Advanced'),
      tiles: [
        SettingsTile(
          title: const Text('Reset settings'),
          leading: const Icon(Icons.restore),
          onPressed: (context) async {
            await showAdaptiveDialog<dynamic>(
              context: context,
              builder: (context) {
                final colorScheme = Theme.of(context).colorScheme;
                return AlertDialog.adaptive(
                  title: const Text('Reset settings'),
                  content: const Text(
                    'Are you sure you want to reset your settings to default? This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref
                            .read(settingsServiceProvider.notifier)
                            .resetSettings();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  List<AbstractSettingsTile> _buildDeveloperSettings({
    required Settings settings,
  }) {
    return <AbstractSettingsTile>[
      if (AppFlavor.isBannerEnabled)
        CustomSettingsTile(
          child: ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text('Enable banner'),
            onTap: () {
              ref.read(settingsServiceProvider.notifier).toggleBanner();
              // TODO: #155 Show snackbar if user has talkback enabled
            },
            trailing: Semantics(
              label: 'Toggle debug banner',
              child: Switch(
                value: settings.bannerEnabled,
                onChanged: (value) {
                  ref.read(settingsServiceProvider.notifier).toggleBanner();
                  // TODO: #155 Show snackbar if user has talkback enabled
                },
              ),
            ),
          ),
        ),
    ];
  }
}

class CustomSettingsTile extends AbstractSettingsTile {
  const CustomSettingsTile({
    required this.child,
    this.padding = EdgeInsetsDirectional.zero,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
