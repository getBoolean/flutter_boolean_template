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
        ? _flavorRaw
        : 'local',
  );
}

enum Flavor { stable, beta, dev, local }
