library constants;

import 'package:env/env.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

/// {@template flavor}
/// Flavor configuration based on the environment variable `FLAVOR`.
/// {@endtemplate}
class AppFlavor {
  /// {@macro constants}
  const AppFlavor._();

  static final Flavor fromEnvironment = Flavor.values.byName(
    Flavor.values.map((type) => type.name).contains(EnvFlavor.rawFlavor)
        ? EnvFlavor.rawFlavor.toLowerCase()
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

extension _FlavorToConfig on Flavor {
  FlavorConfig? createConfig() {
    return switch (this) {
      Flavor.beta => FlavorConfig(
          name: 'BETA',
          color: Colors.deepOrange,
          location: BannerLocation.topEnd,
        ),
      Flavor.dev => FlavorConfig(
          name: 'DEVELOP',
          location: BannerLocation.topEnd,
        ),
      Flavor.staging => FlavorConfig(
          name: 'STAGING',
          color: Colors.green,
          location: BannerLocation.topEnd,
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
        )
      : kReleaseMode
          ? null
          : FlavorConfig(
              name: 'LOCAL',
              color: Colors.blue,
              location: BannerLocation.topEnd,
            );
}
