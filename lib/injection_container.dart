import 'package:dio/dio.dart';
import 'package:etalon/data/data_sources/remote_data_source.dart';
import 'package:etalon/data/repositories/weather_repositories_impl.dart';
import 'package:etalon/domain/repositories/weather_repository.dart';
import 'package:etalon/domain/usecases/get_current_weather.dart';
import 'package:etalon/presentation/bloc/weather_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setUpLocator() {
  //external
  locator.registerLazySingleton(() => Dio());

  //bloc
  locator.registerFactory(() => WeatherBloc(locator()));
  // use case
  locator.registerLazySingleton(
      () => GetWeatherRepositoryUseCase(weatherRepository: locator()));
  //repository
  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()));
  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(dio: locator()));
}
// echo "# etalon" >> README.md
// git init
// git add README.md
// git commit -m "first commit"
// git branch -M main
// git remote add origin https://github.com/akmaljon1016/etalon.git
// git push -u origin main