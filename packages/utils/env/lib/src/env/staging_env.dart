import 'package:envied/envied.dart';

import 'app_env.dart';
import 'app_env_fields.dart';

part 'staging_env.g.dart';

@Envied(name: 'Env', path: 'staging.env')
class StagingEnv implements AppEnv, AppEnvFields {
  const StagingEnv();

  // Providing a default value for everything allows the app to be build
  // without setting up the .env file. This might be useful for someone
  // who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL', defaultValue: '')
  final String baseUrl = _Env.baseUrl;
}
