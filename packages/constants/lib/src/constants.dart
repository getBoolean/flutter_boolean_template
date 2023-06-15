import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

/// {@template constants}
/// Shared constant variables for Dart/Flutter
/// {@endtemplate}
class Constants {
  /// {@macro constants}
  const Constants._();

  // ignore: do_not_use_environment
  static const String _flavorRaw = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'local',
  );

  static final Flavor flavor = Flavor.values.byName(
    Flavor.values.map((type) => type.name).contains(_flavorRaw)
        ? _flavorRaw.toLowerCase()
        : 'local',
  );

  static FlavorConfig? _flavorConfig;

  /// Creates a [FlavorConfig] based on the current [flavor].
  ///
  /// If the [flavor] is [Flavor.prod] or [Flavor.staging],
  /// then no [FlavorConfig] is created.
  static FlavorConfig? get flavorConfig =>
      _flavorConfig ??= flavor.createConfig();
}

enum Flavor {
  /// Production version, usually built and signed using CodeMagic or other CI/CD and deployed to stores
  prod,

  /// Pre-release version, usually branch intended for release on TestFlight or other beta testing platform
  beta,

  /// Staging version, usually built and signed and deployed for internal testing (such as integration tests)
  staging,

  /// Development version, usually either branch `main` or `dev`.
  dev,

  /// Locally built, usually for debugging or testing changes.
  local,
}

extension _FlavorToConfig on Flavor {
  FlavorConfig? createConfig() {
    return switch (this) {
      Flavor.beta => FlavorConfig(
          name: 'BETA',
          color: Colors.deepOrange,
          location: BannerLocation.topEnd,
          variables: {},
        ),
      Flavor.dev => FlavorConfig(
          name: 'DEV',
          color: Colors.red,
          location: BannerLocation.topEnd,
          variables: {},
        ),
      Flavor.local => _createDebugModeFlavor(),
      _ => null,
    };
  }

  FlavorConfig _createDebugModeFlavor() => kDebugMode
      ? FlavorConfig(
          name: 'DEBUG',
          color: Colors.blue,
          location: BannerLocation.topEnd,
          variables: {},
        )
      : FlavorConfig(
          name: 'LOCAL',
          color: Colors.blue,
          location: BannerLocation.topEnd,
          variables: {},
        );
}
