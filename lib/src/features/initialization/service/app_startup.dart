import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/initialization/service/info_service.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/navigation_type_override.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/settings.dart';
import 'package:flutter_boolean_template/src/features/settings/data/repository/settings_repository.dart';
import 'package:flutter_boolean_template/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window_manager/window_manager.dart';

part 'app_startup.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(AppStartupRef ref) async {
  ref.onDispose(() {
    // invalidate all the providers we depend on
    ref.invalidate(packageInfoProvider);
  });
  // all asynchronous app initialization code should belong here:
  await (
    _initWindow(),
    _initHive(),
    ref.watch(packageInfoProvider.future),
  ).wait;
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(NavigationTypeOverrideAdapter());
  final documentsDirectory = await $applicationDocumentsDirectory();
  await SettingsRepository.initBox(documentsDirectory?.path);
}

Future<void> _initWindow() async {
  if (!kIsWeb &&
      (io.Platform.isWindows || io.Platform.isLinux || io.Platform.isMacOS)) {
    await windowManager.ensureInitialized();
    await windowManager.setMinimumSize(const Size(600, 300));
  }
}
