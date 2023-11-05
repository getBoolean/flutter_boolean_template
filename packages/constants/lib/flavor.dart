library constants;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

/// {@template flavor}
/// Flavor configuration based on the environment variable `FLAVOR`.
/// {@endtemplate}
class AppFlavor {
  /// {@macro constants}
  const AppFlavor._();

  // ignore: do_not_use_environment
  static const String _flavorRaw = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'local',
  );

  static final Flavor fromEnvironment = Flavor.values.byName(
    Flavor.values.map((type) => type.name).contains(_flavorRaw)
        ? _flavorRaw.toLowerCase()
        : 'local',
  );

  static FlavorConfig? _flavorConfig;

  static FlavorConfig? initConfig() => config;

  /// Creates a [FlavorConfig] based on the current [fromEnvironment].
  ///
  /// If the [fromEnvironment] is [Flavor.prod] or [Flavor.staging],
  /// then no [FlavorConfig] is created.
  static FlavorConfig? get config =>
      _flavorConfig ??= fromEnvironment.createConfig();

  static bool get isBannerEnabled => config != null && !kReleaseMode;
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
          name: 'DEVELOP',
          color: Colors.red,
          location: BannerLocation.topEnd,
          variables: {},
        ),
      Flavor.local => _createDebugModeFlavor(),
      _ => null,
    };
  }

  FlavorConfig? _createDebugModeFlavor() => kDebugMode
      ? FlavorConfig(
          name: 'DEBUG',
          color: Colors.blue,
          location: BannerLocation.topEnd,
          variables: {},
        )
      : kReleaseMode
          ? null
          : FlavorConfig(
              name: 'LOCAL',
              color: Colors.blue,
              location: BannerLocation.topEnd,
              variables: {},
            );
}
