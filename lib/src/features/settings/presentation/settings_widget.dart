import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/main.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsWidget extends HookWidget {
  const SettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<bool>(bannerBox).listenable(),
      builder: (context, box, widget) {
        final bannerEnabled =
            box.get('bannerEnabled', defaultValue: true) ?? true;
        return SettingsList(
          platform: DevicePlatform.android,
          sections: [
            SettingsSection(
              title: const Text('Common'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  onToggle: (value) async {
                    final box = await Hive.openBox<bool>(bannerBox);
                    await box.put('bannerEnabled', value);
                  },
                  initialValue: bannerEnabled,
                  leading: const Icon(Icons.bug_report),
                  title: const Text('Enable banner'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
