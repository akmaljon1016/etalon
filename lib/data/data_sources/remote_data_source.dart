import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:etalon/core/constants/constants.dart';
import 'package:etalon/core/error/exception.dart';
import 'package:etalon/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await dio.get(Urls.currentWeatherByName(cityName));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
