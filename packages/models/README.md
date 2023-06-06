
# Models

This package should contain all models used by the application. If you are worried about
the analyzer slowing down from exporting all models, create a separate barrel file
for each category instead of the single [models.dart](./lib/models.dart) file.

Models can be created with both [dart_mappable](https://pub.dev/packages/dart_mappable)
and [modddels](https://pub.dev/packages/modddels). Modddels provides type-safe data
validation and is recommended for all models. This can work together, but a custom
`Mapper` class will need to be created for each model.
