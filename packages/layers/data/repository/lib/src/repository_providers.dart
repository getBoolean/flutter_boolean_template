import 'package:data_source/data_source.dart';
import 'package:http/http.dart' as http;
import 'package:repository/src/weather/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod
HttpWeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  return HttpWeatherRepository(
    api: OpenWeatherMapAPI(''),
    client: http.Client(),
  );
}
