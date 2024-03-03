import 'package:env/src/env/config/env_fields.dart';
import 'package:env/src/env/config/env_flavor.dart';
import 'package:envied/envied.dart';

part 'dev_env.g.dart';

@Envied(name: 'Env', path: 'dev.env', allowOptionalFields: true)
class DevEnv implements EnvFlavor, EnvFields {
  DevEnv();

  // Using nullable types or providing a default value for everything allows
  // the app to be build without setting up the .env file. This would be
  // useful for someone who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL')
  final String? baseUrl = _Env.baseUrl;

  @override
  @EnviedField(varName: 'USE_PATH_URL_STRATEGY', defaultValue: true)
  final bool usePathUrlStrategy = _Env.usePathUrlStrategy;
}
