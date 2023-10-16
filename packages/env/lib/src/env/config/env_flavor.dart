import 'package:constants/constants.dart';
import 'package:env/src/env/config/env_fields.dart' show EnvFieldsNonNull;
import 'package:env/src/env/dev_env.dart';
import 'package:env/src/env/local_env.dart';
import 'package:env/src/env/prod_env.dart';
import 'package:env/src/env/staging_env.dart';

abstract class EnvFlavor implements EnvFieldsNonNull {
  static EnvFlavor? _instance;

  factory EnvFlavor() {
    return _instance ??= switch (Constants.flavor) {
      Flavor.prod || Flavor.beta => const ProdEnv(),
      Flavor.staging => const StagingEnv(),
      Flavor.dev => const DevEnv(),
      Flavor.local => const LocalEnv(),
    };
  }
}
