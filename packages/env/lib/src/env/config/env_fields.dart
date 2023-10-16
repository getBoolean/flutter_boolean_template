import 'package:env/src/env/config/env_flavor.dart' show EnvFlavor;

/// Adapter class to handle empty strings in [EnvFlavor] as null values
class Env {
  Env._();

  static EnvFlavor get raw => EnvFlavor();

  // TODO: Add static fields here and in [EnvFieldsNullable]. These should all be the same as [EnvFieldsNonNull] but nullable
  static final String? baseUrl = raw.baseUrl.nullIfEmpty;
}

/// All Env classes must implement all these values
abstract class EnvFieldsNonNull {
  // TODO: Add non-null non-static fields here and in the class for each flavor: [AppEnv], [DevEnv], [LocalEnv], [ProdEnv], and [StagingEnv]
  abstract final String baseUrl;
}

extension _StringExtension on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}
