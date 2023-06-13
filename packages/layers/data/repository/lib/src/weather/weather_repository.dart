import 'package:data_source/data_source.dart';
import 'package:dto/dto.dart';
import 'package:http/http.dart' as http;

class HttpWeatherRepository implements WeatherRepository {
  HttpWeatherRepository({required this.api, required this.client});
  // custom class defining all the API details
  final OpenWeatherMapAPI api;
  // client for making calls to the API
  final http.Client client;

  @override
  Future<Weather> getWeather({required String city}) async {
    final result = await client.get(api.weather(city));
    return Weather.fromJson(result.body);
  }
}

abstract class WeatherRepository {
  Future<Weather> getWeather({required String city});
}
