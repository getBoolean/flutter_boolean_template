import 'package:env/src/env/config/env_fields.dart';
import 'package:env/src/env/config/env_flavor.dart';
import 'package:envied/envied.dart';

part 'local_env.g.dart';

@Envied(name: 'Env', path: 'local.env')
class LocalEnv implements EnvFlavor, EnvFieldsNonNull {
  const LocalEnv();

  // Providing a default value for everything allows the app to be build
  // without setting up the .env file. This might be useful for someone
  // who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL', defaultValue: '')
  final String baseUrl = _Env.baseUrl;
}
