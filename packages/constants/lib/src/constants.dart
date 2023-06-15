import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

/// {@template constants}
/// Shared constant variables for Dart/Flutter
/// {@endtemplate}
class Constants {
  /// {@macro constants}
  Constants._();

  static final Constants instance = Constants._();

  // ignore: do_not_use_environment
  static const String _flavorRaw = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'local',
  );

  final Flavor flavor = Flavor.values.byName(
    Flavor.values.map((type) => type.name).contains(_flavorRaw)
        ? _flavorRaw.toLowerCase()
        : 'local',
  );

  FlavorConfig? createFlavorConfig() => flavor.config;
}

enum Flavor {
  /// Production version, usually built and signed using CodeMagic or other CI/CD and deployed to stores
  prod,

  /// Staging version, usually built and signed and deployed for internal testing (such as integration tests)
  staging,

  /// Pre-release version, usually branch intended for release on TestFlight or other beta testing platform
  beta,

  /// Development version, usually either branch `main` or `dev`
  dev,

  /// Locally built, usually for debugging
  local,
}

extension _FlavorToConfig on Flavor {
  FlavorConfig? get config {
    return switch (this) {
      Flavor.beta => FlavorConfig(
          name: 'Beta',
          color: Colors.orange,
          location: BannerLocation.topStart,
          variables: {},
        ),
      Flavor.dev => FlavorConfig(
          name: 'Dev',
          color: Colors.red,
          location: BannerLocation.topStart,
          variables: {},
        ),
      Flavor.local => _createDebugModeFlavor(),
      _ => null,
    };
  }

  FlavorConfig _createDebugModeFlavor() => kDebugMode
      ? FlavorConfig(
          name: 'Debug',
          color: Colors.blue,
          location: BannerLocation.topStart,
          variables: {},
        )
      : FlavorConfig(
          name: 'Local',
          color: Colors.blue,
          location: BannerLocation.topStart,
          variables: {},
        );
}
