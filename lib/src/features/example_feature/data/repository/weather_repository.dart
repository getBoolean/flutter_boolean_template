import 'package:flutter_boolean_template/src/features/example_feature/data/data_source/weather_api.dart';
import 'package:flutter_boolean_template/src/features/example_feature/data/dto/weather.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRepository {
  Future<Weather> getWeather({required String city});
}

class HttpWeatherRepository implements WeatherRepository {
  /// custom class defining all the API details
  final OpenWeatherMapAPI api;

  /// client for making calls to the API
  final http.Client client;

  HttpWeatherRepository({required this.api, required this.client});

  @override
  Future<Weather> getWeather({required String city}) async {
    final result = await client.get(api.weather(city));

    return Weather.fromJson(result.body);
  }
}
