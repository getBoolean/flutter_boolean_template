import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boolean_template/src/features/initialization/application/info_service.dart';
import 'package:flutter_boolean_template/src/features/settings/application/settings_service.dart';
import 'package:flutter_boolean_template/src/features/settings/application/themes.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/navigation_type_override.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/theme_type.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/extensions.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/widgets/segmented_button_tile.dart';
import 'package:flutter_boolean_template/src/features/settings/presentation/widgets/theme_selector_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log/log.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingDetailsRootScreen extends StatefulWidget {
  const SettingDetailsRootScreen({super.key, this.id});

  final String? id;

  @override
  State<SettingDetailsRootScreen> createState() =>
      _SettingDetailsRootScreenState();
}

class _SettingDetailsRootScreenState extends State<SettingDetailsRootScreen> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.id) {
      'about' => const AboutSettingsScreen(),
      'appearance' => const AppearanceSettingsScreen(),
      _ => ColoredBox(
          color: Colors.redAccent,
          child: Center(child: Text(' ${widget.id ?? 'Unknown'}Setting')),
        )
    };
  }
}

//         // show licenses dialog
//         SettingsTile(
//           title: const Text('Open Source Licenses'),
//           leading: const Icon(Icons.description),
//           onPressed: (context) async {
//             showLicensePage(
//               context: context,
//               applicationName: packageInfo.requireValue.appName,
//               useRootNavigator: true,
//             );
//           },
//         ),
//         // github
//         SettingsTile(
//           title: const Text('GitHub'),
//           leading: const Icon(Icons.code),
//           value: const Text('getBoolean/flutter_boolean_template'),
//           onPressed: (context) async {
//             final url = Uri.parse(
//               'https://www.github.com/getBoolean/flutter_boolean_template',
//             );
//             try {
//               final success = await launchUrl(url);
//               if (!success) {
//                 _logger.fine('Could not launch url: ${url.path}');
//               }
//             } on PlatformException catch (e, st) {
//               _logger.severe('Could not launch url: ${e.message}', e, st);
//             }
//           },
//         ),

class AboutSettingsScreen extends ConsumerStatefulWidget {
  const AboutSettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AboutSettingsScreenState();
}

class _AboutSettingsScreenState extends ConsumerState<AboutSettingsScreen> {
  static final Logger _logger = Logger('AboutSettingsScreen');

  late SystemClipboard? clipboard;

  @override
  void initState() {
    super.initState();
    clipboard = SystemClipboard.instance;
  }

  @override
  Widget build(BuildContext context) {
    final packageInfo = ref.watch(packageInfoProvider);
    return Material(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Version'),
            leading: const Icon(Icons.info),
            subtitle: Text(
              'v${packageInfo.requireValue.version}+${packageInfo.requireValue.buildNumber}',
            ),
            onTap: clipboard == null
                ? null
                : () async {
                    final item = DataWriterItem();
                    item.add(
                      Formats.plainText(
                        'v${packageInfo.requireValue.version}+${packageInfo.requireValue.buildNumber}',
                      ),
                    );
                    await clipboard!.write([item]);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Version copied to clipboard'),
                        ),
                      );
                    }
                  },
          ),
          ListTile(
            title: const Text('Open Source Licenses'),
            leading: const Icon(Icons.description),
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: packageInfo.requireValue.appName,
                useRootNavigator: true,
              );
            },
          ),
          ListTile(
            title: const Text('GitHub'),
            leading: const Icon(Icons.code),
            subtitle: const Text('getBoolean/flutter_boolean_template'),
            onTap: () async {
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
      ),
    );
  }
}

class AppearanceSettingsScreen extends ConsumerWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsServiceProvider);
    final isLight = Theme.of(context).brightness == Brightness.light;
    final themes = ref.watch(themesProvider);
    return Material(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SegmentedButtonTile(
            initial: settings.themeType,
            segments: const [
              ThemeType.system,
              ThemeType.dark,
              ThemeType.light,
            ],
            onTap: (themeType) {
              ref
                  .read(settingsServiceProvider.notifier)
                  .setThemeType(themeType);
            },
          ),
          ThemeSelectorTile(
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
          ),
          ListTile(
            title: const Text('Portrait Navigation'),
            subtitle: Text(settings.portraitNavigationTypeOverride.humanName),
            onTap: () async {
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
          ListTile(
            title: const Text('Landscape Navigation'),
            subtitle: Text(settings.landscapeNavigationTypeOverride.humanName),
            onTap: () async {
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
      ),
    );
  }
}
