import 'package:flutter_boolean_template/src/features/example_feature/data/data_source/weather_api.dart';
import 'package:flutter_boolean_template/src/features/example_feature/data/repository/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod
HttpWeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  return HttpWeatherRepository(
    api: OpenWeatherMapAPI(''),
    client: http.Client(),
  );
}
