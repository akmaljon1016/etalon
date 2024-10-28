import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:etalon/core/constants/constants.dart';
import 'package:etalon/data/data_sources/remote_data_source.dart';
import 'package:etalon/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockDio mockDio;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(dio: mockDio);
  });

  const testCityName = "New York";
  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {

      //arrange
      when(mockDio.get(Urls.currentWeatherByName(testCityName)))
          .thenAnswer((_) async {
        return Response(
            statusCode: 200,
            data: json.decode(readJson('helpers/dummy_weather_response.json')),
            requestOptions: RequestOptions());
      });

      //act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, isA<WeatherModel>());
    });
  });
}
