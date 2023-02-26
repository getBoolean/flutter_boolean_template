import 'package:envied/envied.dart';

import 'app_env.dart';
import 'app_env_fields.dart';

part 'profile_env.g.dart';

@Envied(name: 'Env', path: '.env_profile')
class ProfileEnv implements AppEnv, AppEnvFields {
  ProfileEnv();

  @override
  @EnviedField(varName: 'KEY1')
  final String key1 = _Env.key1;
  @override
  @EnviedField(varName: 'KEY2')
  final String key2 = _Env.key2;
  @override
  @EnviedField(varName: 'KEY3', obfuscate: true)
  final String key3 = _Env.key3;
  @override
  @EnviedField(varName: 'KEY4')
  final int key4 = _Env.key4;
  @override
  @EnviedField(varName: 'KEY5')
  final bool key5 = _Env.key5;
}
