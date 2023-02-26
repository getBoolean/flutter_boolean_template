import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'app_method_channel.dart';

abstract class AppPlatform extends PlatformInterface {
  /// Constructs a AppPlatform.
  AppPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppPlatform _instance = MethodChannelApp();

  /// The default instance of [AppPlatform] to use.
  ///
  /// Defaults to [MethodChannelApp].
  static AppPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppPlatform] when
  /// they register themselves.
  static set instance(AppPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
