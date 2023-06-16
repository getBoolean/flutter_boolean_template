import 'package:constants/constants.dart';

import 'app_env_fields.dart';
import 'dev_env.dart';
import 'local_env.dart';
import 'prod_env.dart';
import 'staging_env.dart';

abstract class AppEnv implements AppEnvFieldsGenerated {
  // ignore: prefer_constructors_over_static_methods
  static AppEnv get instance => _instance ??= AppEnv._();

  factory AppEnv._() {
    return switch (Constants.flavor) {
      Flavor.prod || Flavor.beta => const ProdEnv(),
      Flavor.staging => const StagingEnv(),
      Flavor.dev => const DevEnv(),
      Flavor.local => const LocalEnv(),
    };
  }

  static AppEnv? _instance;
}
