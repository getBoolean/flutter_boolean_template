/// All Env classes must implement all these values
abstract class AppEnvFieldsGenerated {
  // TODO: Add fields here and in the following classes: [AppEnv], [DevEnv], [LocalEnv], [ProdEnv], and [StagingEnv]
  abstract final String baseUrl;
}

abstract class AppEnvFieldsNullable {
  // TODO: Add fields here and in [Env]. These should be the same as [AppEnvFieldsGenerated] but nullable
  abstract final String? baseUrl;
}
