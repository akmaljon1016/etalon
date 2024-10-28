import 'package:dartz/dartz.dart';
import 'package:etalon/core/error/failure.dart';
import 'package:etalon/core/utils/result.dart';
import 'package:etalon/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
