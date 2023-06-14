import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data_source/weather_api.dart';
import 'weather_repository.dart';

part 'repository_providers.g.dart';

@riverpod
HttpWeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  return HttpWeatherRepository(
    api: OpenWeatherMapAPI(''),
    client: http.Client(),
  );
}
