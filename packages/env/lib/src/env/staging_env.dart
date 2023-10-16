import 'package:env/src/env/app_env.dart';
import 'package:env/src/env/app_env_fields.dart';
import 'package:envied/envied.dart';

part 'staging_env.g.dart';

@Envied(name: 'Env', path: 'staging.env')
class StagingEnv implements AppEnv, AppEnvFieldsGenerated {
  const StagingEnv();

  // Providing a default value for everything allows the app to be build
  // without setting up the .env file. This might be useful for someone
  // who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL', defaultValue: '')
  final String baseUrl = _Env.baseUrl;
}
