import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'app_platform_interface.dart';

/// An implementation of [AppPlatform] that uses method channels.
class MethodChannelApp extends AppPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('app');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
