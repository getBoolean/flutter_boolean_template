import 'package:dart_mappable/dart_mappable.dart';

part 'weather.mapper.dart';

// Converted to dart_mappable. Original: https://github.com/bizz84/open_weather_example_flutter/blob/main/lib/src/entities/weather/weather.dart

@MappableClass()
class WeatherParams with WeatherParamsMappable {
  @MappableField(key: 'temp')
  final double temp;
  @MappableField(key: 'temp_min')
  final double tempMin;
  @MappableField(key: 'temp_max')
  final double tempMax;

  const WeatherParams({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  static const fromMap = WeatherParamsMapper.fromMap;
  static const fromJson = WeatherParamsMapper.fromJson;
}

@MappableClass()
class WeatherInfo with WeatherInfoMappable {
  @MappableField()
  final String main;
  @MappableField()
  final String description;
  @MappableField()
  final String icon;

  const WeatherInfo({
    required this.main,
    required this.description,
    required this.icon,
  });

  static const fromMap = WeatherInfoMapper.fromMap;
  static const fromJson = WeatherInfoMapper.fromJson;
}

@MappableClass()
class Weather with WeatherMappable {
  @MappableField(key: 'main')
  final WeatherParams weatherParams;
  @MappableField(key: 'weather')
  final List<WeatherInfo> weatherInfo;
  @MappableField()
  final int dt;

  const Weather({
    required this.weatherParams,
    required this.weatherInfo,
    required this.dt,
  });

  static const fromMap = WeatherMapper.fromMap;
  static const fromJson = WeatherMapper.fromJson;
}
