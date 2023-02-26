import 'package:flutter/foundation.dart';

import 'app_env_fields.dart';
import 'debug_env.dart';
import 'profile_env.dart';
import 'release_env.dart';

abstract class AppEnv implements AppEnvFields {
  factory AppEnv() => instance;

  static final AppEnv instance = kDebugMode
      ? DebugEnv()
      : kProfileMode
          ? ProfileEnv()
          : ReleaseEnv();
}
