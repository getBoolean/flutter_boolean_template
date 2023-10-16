import 'package:env/src/env/app_env_fields.dart';
import 'package:env/src/env/dev_env.dart';
import 'package:env/src/env/local_env.dart';
import 'package:env/src/env/prod_env.dart';
import 'package:env/src/env/staging_env.dart';
import 'package:flutter_boolean_template/constants/constants.dart';

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
