import 'package:dartz/dartz.dart';
import 'package:etalon/core/error/failure.dart';
import 'package:etalon/core/utils/result.dart';
import 'package:etalon/domain/entities/weather.dart';
import 'package:etalon/domain/repositories/weather_repository.dart';

class GetWeatherRepositoryUseCase {
  final WeatherRepository weatherRepository;

  GetWeatherRepositoryUseCase({required this.weatherRepository});

  Future<Either<Failure,WeatherEntity>> call({required String cityName}) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
