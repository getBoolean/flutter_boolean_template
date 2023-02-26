import 'package:envied/envied.dart';

import 'app_env.dart';
import 'app_env_fields.dart';

part 'release_env.g.dart';

@Envied(name: 'Env', path: '.env_release')
class ReleaseEnv implements AppEnv, AppEnvFields {
  ReleaseEnv();

  // Providing a default value for everything allows the app to be build
  // without setting up the .env file. This might be useful for someone
  // who wants to build the app without setting up cloud services.

  @override
  @EnviedField(varName: 'KEY1', defaultValue: 'test1')
  final String key1 = _Env.key1;
  @override
  @EnviedField(varName: 'KEY2', defaultValue: 'test2')
  final String key2 = _Env.key2;
  @override
  @EnviedField(varName: 'KEY3', obfuscate: true, defaultValue: 'test3')
  final String key3 = _Env.key3;
  @override
  @EnviedField(varName: 'KEY4', defaultValue: 1)
  final int key4 = _Env.key4;
  @override
  @EnviedField(varName: 'KEY5', defaultValue: false)
  final bool key5 = _Env.key5;
}
