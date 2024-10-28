import 'package:dartz/dartz.dart';
import 'package:etalon/data/models/weather_model.dart';
import 'package:etalon/data/repositories/weather_repositories_impl.dart';
import 'package:etalon/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
      cityName: 'New York',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const testWeatherEntity = WeatherEntity(
      cityName: 'New York',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const cityName = "New York";

  group('get current weather', () {
    test(
        'should return current weather when a call to data source is successful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(cityName))
          .thenAnswer((_) async => testWeatherModel);
      //act
      final result = await weatherRepositoryImpl.getCurrentWeather(cityName);
      //assert
      expect(result, equals(const Right(testWeatherEntity)));
    });
  });
}
