# Env

Environment variables with type safety. Empty strings are treated as null values.

## Getting started

1. Add environment fields to [env_fields.dart](lib/src/env/config/env_fields.dart).
1. Customize flavors in [env_flavor.dart](lib/src/env/config/env_flavor.dart), adding or removing flavors to fit the app's needs.
1. Implement environment fields for each flavor
   - For the app to build without an `.env` file for each flavor, assign a default value all fields.

## Usage

```dart
const String url = Env.baseUrl ?? 'https://example.com';
const String? urlNullable = Env.baseUrl;
const String urlEmpty = Env.raw.baseUrl;
```
