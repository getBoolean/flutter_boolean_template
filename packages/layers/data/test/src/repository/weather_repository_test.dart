import 'package:data/data.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockWeatherRepository extends Mock implements HttpWeatherRepository {}
class MockHttpClient extends Mock implements http.Client {}

const kWeather = Weather(
  dt: 0,
  weatherInfo: [],
  weatherParams: WeatherParams(temp: 5, tempMax: 10, tempMin: 0),
);

void main() {
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });

  test('weather repository ...', () async {
    when(() => mockWeatherRepository.getWeather(city: 'London')).thenAnswer(
      (_) => Future.value(kWeather),
    );

    final weather = await mockWeatherRepository.getWeather(city: 'London');
    expect(
      weather,
      equals(kWeather),
    );
  });

  test('repository with mocked http client', () async {
    // setup
    final mockHttpClient = MockHttpClient();
    final api = OpenWeatherMapAPI('apikey');
    final weatherRepository = HttpWeatherRepository(
      api: api,
      client: mockHttpClient,
    );

    when(() => mockHttpClient.get(api.weather('London')))
        .thenAnswer((_) => Future.value(Response('''
{"main":{"temp":5.0,"temp_min":0.0,"temp_max":10.0},"weather":[],"dt":0}
''', 200)));

    // run
    final weather = await weatherRepository.getWeather(city: 'London');
    // verify
    expect(weather, equals(kWeather));
  });
}
