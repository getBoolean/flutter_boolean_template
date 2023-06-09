import 'package:http/http.dart' as http;

import '../data_source/weather_api.dart';
import '../entity/weather.dart';

class HttpWeatherRepository implements WeatherRepository {
  HttpWeatherRepository({required this.api, required this.client});
  // custom class defining all the API details
  final OpenWeatherMapAPI api;
  // client for making calls to the API
  final http.Client client;

  @override
  Future<Weather> getWeather({required String city}) {
    throw UnimplementedError();
  }
}

abstract class WeatherRepository {
  Future<Weather> getWeather({required String city});
}
