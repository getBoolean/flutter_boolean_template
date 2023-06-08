
# Data

This package should contain all DTOs (entities), Repositories, and Data Sources (e.g., API access) for the application.

## DTOs

- DTOs (Data Transfer Objects) are models that are used to transfer data between
the application and the API. They **should** be created with [dart_mappable](https://pub.dev/packages/dart_mappable)
if JSON serialization is required.
  - Do NOT use the package [modddels](https://pub.dev/packages/modddels) with DTOs.
  The package is intended for Domain models (entities) only.
  - If you are worried about the analyzer slowing down from exporting all models,
  create a separate barrel file for each category instead of the single [models.dart](./lib/models.dart) file.

## Resources

- [Dart Mappable Documentation](https://pub.dev/documentation/dart_mappable/latest/topics/Introduction-topic.html)
- [Repository Pattern Guide by CodeWithAndrea](https://codewithandrea.com/articles/flutter-repository-pattern/)
