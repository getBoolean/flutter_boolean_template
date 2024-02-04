import 'package:constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boolean_template/src/features/initialization/application/info_service.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/application/themes.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/navigation_type_override.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/theme_type.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/extensions.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/widgets/segmented_button_tile.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/widgets/theme_selector_tile.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log/log.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsWidget extends StatefulHookConsumerWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  ConsumerState<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends ConsumerState<SettingsWidget> {
  final Logger _logger = Logger('SettingsWidget');
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsServiceProvider);
    final developerSettings = _buildDeveloperSettings(settings: settings);
    final theme = Theme.of(context);
    final packageInfo = ref.watch(packageInfoProvider);
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
        buildAppearanceSection(settings),
        buildAboutSection(packageInfo),
        buildAdvancedSection(),
        if (developerSettings.isNotEmpty && !kReleaseMode)
          SettingsSection(
            title: const Text('Developer'),
            tiles: developerSettings,
          ),
      ],
    );
  }

  SettingsSection buildAboutSection(AsyncValue<PackageInfo> packageInfo) {
    return SettingsSection(
      title: const Text('About'),
      tiles: [
        SettingsTile(
          title: const Text('Version'),
          leading: const Icon(Icons.info),
          value: Text(
            'v${packageInfo.requireValue.version}+${packageInfo.requireValue.buildNumber}',
          ),
        ),
        // show licenses dialog
        SettingsTile(
          title: const Text('Open Source Licenses'),
          leading: const Icon(Icons.description),
          onPressed: (context) async {
            showLicensePage(
              context: context,
              applicationName: packageInfo.requireValue.appName,
              useRootNavigator: true,
            );
          },
        ),
        // github
        SettingsTile(
          title: const Text('GitHub'),
          leading: const Icon(Icons.code),
          value: const Text('getBoolean/flutter_boolean_template'),
          onPressed: (context) async {
            final url = Uri.parse(
              'https://www.github.com/getBoolean/flutter_boolean_template',
            );
            try {
              final success = await launchUrl(url);
              if (!success) {
                _logger.fine('Could not launch url: ${url.path}');
              }
            } on PlatformException catch (e, st) {
              _logger.severe('Could not launch url: ${e.message}', e, st);
            }
          },
        ),
      ],
    );
  }

  SettingsSection buildAppearanceSection(Settings settings) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return SettingsSection(
      title: const Text('Appearance'),
      tiles: [
        SegmentedButtonTile(
          initial: settings.themeType,
          segments: const [
            ThemeType.system,
            ThemeType.dark,
            ThemeType.light,
          ],
          onTap: (themeType) {
            ref.read(settingsServiceProvider.notifier).setThemeType(themeType);
          },
        ),
        CustomSettingsTile(
          padding: const EdgeInsets.only(left: 8),
          child: Consumer(
            builder: (context, ref, child) {
              final themes = ref.watch(themesProvider);
              return ThemeSelectorTile(
                selected: isLight ? settings.lightTheme : settings.darkTheme,
                schemes: themes,
                colorProvider: (data) => isLight ? data.light : data.dark,
                onTap: (scheme) {
                  isLight
                      ? ref
                          .read(settingsServiceProvider.notifier)
                          .setLightTheme(scheme)
                      : ref
                          .read(settingsServiceProvider.notifier)
                          .setDarkTheme(scheme);
                },
              );
            },
          ),
        ),
        SettingsTile.navigation(
          title: const Text('Portrait Navigation'),
          value: Text(settings.portraitNavigationTypeOverride.humanName),
          onPressed: (context) async {
            final navigationTypeOverride = await context.showOptionsMenu<
                NavigationTypeOverride, NavigationTypeOverride>(
              title: 'Portrait Navigation',
              current: settings.portraitNavigationTypeOverride,
              options: NavigationTypeOverride.values,
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
              title: 'Landscape Navigation',
              current: settings.landscapeNavigationTypeOverride,
              options: NavigationTypeOverride.values,
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

class CustomSettingsTile extends AbstractSettingsTile {
  const CustomSettingsTile({
    required this.child,
    this.padding,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.only(start: 24),
      child: child,
    );
  }
}
