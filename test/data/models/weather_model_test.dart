import 'dart:convert';

import 'package:etalon/data/models/weather_model.dart';
import 'package:etalon/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  const weatherDetail = WeatherModel(
      cityName: 'Fergana',
      main: 'Clear',
      description: 'clear sky',
      iconCode: '01d',
      temperature: 300.24,
      pressure: 1014,
      humidity: 19);

  test('should be subclass of weather entity', () async {
    expect(weatherDetail, isA<WeatherEntity>());
  });

  test('should return a valid model from json', () async {
    //arrange

    final Map<String, dynamic> jsonMap =
    json.decode(readJson('helpers/dummy_weather_response.json'));
    //act
    final result = WeatherModel.fromJson(jsonMap);
    //expect
    expect(result, equals(weatherDetail));
  });
}
