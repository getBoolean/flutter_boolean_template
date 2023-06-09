
# Domain

This package should contain all application-wide domain models, especially if they require
serialization.

## Domain-Driven Design (DDD)

### Entity Objects (Models)

- These models are instantiated after user interaction, such as filling out a form.
  - Any models created by API repositories should instead be created in the [data](/packages/layers/data/) package.
- JSON serialization is implemented using [dart_mappable](https://pub.dev/packages/dart_mappable).
- Data validation is implemented using [modddels](https://pub.dev/packages/moddels).
- Entities have an identity (e.g., `customer.id`).
- All entity fields must be value objects. (i.e., not `String`, `int`, `double`, etc.)

### Value Objects

- Immutable objects that represent a value in an entity.
- Value objects do not have an identity (e.g., `customer.address`).
- Freezed is only unsed on Union error types.

## Resources

- [Dart Mappable Documentation](https://pub.dev/documentation/dart_mappable/latest/topics/Introduction-topic.html)
- [Moddels Documentation](https://docs.modddels.dev/)
- [Domain Model Article by CodeWithAndrea](https://codewithandrea.com/articles/flutter-app-architecture-domain-model/)
