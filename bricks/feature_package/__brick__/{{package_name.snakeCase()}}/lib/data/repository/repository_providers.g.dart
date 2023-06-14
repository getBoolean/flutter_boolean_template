// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherRepositoryHash() => r'8ae397422adc069b5cc48dfafc03e9697d4087a4';

/// See also [weatherRepository].
@ProviderFor(weatherRepository)
final weatherRepositoryProvider =
    AutoDisposeProvider<HttpWeatherRepository>.internal(
  weatherRepository,
  name: r'weatherRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WeatherRepositoryRef = AutoDisposeProviderRef<HttpWeatherRepository>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
