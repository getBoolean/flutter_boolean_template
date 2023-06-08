
# Domain

This package should contain all application-wide domain models, especially if they require
serialization.

## Models

- These models are instantiated after user interaction, such as filling out a form.
  - Any models created by API repositories should instead be created in the [data](/packages/data/) package.
- JSON serialization is implemented using [dart_mappable](https://pub.dev/packages/dart_mappable).
- Data validation is implemented using [modddels](https://pub.dev/packages/moddels).

## Resources

- [Dart Mappable Documentation](https://pub.dev/documentation/dart_mappable/latest/topics/Introduction-topic.html)
- [Moddels Documentation](https://docs.modddels.dev/)
- [Repository Pattern Article by CodeWithAndrea](https://codewithandrea.com/articles/flutter-repository-pattern/)
