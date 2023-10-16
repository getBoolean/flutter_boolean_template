import 'package:env/src/env/app_env.dart';
import 'package:env/src/env/app_env_fields.dart';

/// Adapter class to handle empty strings in [AppEnv] as null values
class Env implements AppEnvFieldsNullable {
  Env._();
  static Env instance = Env._();
  static AppEnv get _instance => AppEnv.instance;

  // TODO: Add fields here and in [AppEnvFieldsNullable]. These should all be the same as [AppEnvFieldsGenerated] but nullable for empty strings
  final String? baseUrl = _instance.baseUrl.valueIfNotEmptyElseNull;
}

extension _StringExtension on String {
  String? get valueIfNotEmptyElseNull => isNotEmpty ? this : null;
}
