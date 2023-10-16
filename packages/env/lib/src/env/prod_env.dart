import 'package:env/src/env/config/env_fields.dart';
import 'package:env/src/env/config/env_flavor.dart';
import 'package:envied/envied.dart';

part 'prod_env.g.dart';

@Envied(name: 'Env', path: 'prod.env')
class ProdEnv implements EnvFlavor, EnvFieldsNonNull {
  const ProdEnv();

  // Providing a default value for everything allows the app to be build
  // without setting up the .env file. This might be useful for someone
  // who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'BASE_URL', defaultValue: '')
  final String baseUrl = _Env.baseUrl;
}
