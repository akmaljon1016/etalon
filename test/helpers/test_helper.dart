import 'package:dio/dio.dart';
import 'package:etalon/data/data_sources/remote_data_source.dart';
import 'package:etalon/domain/usecases/get_current_weather.dart';
import 'package:etalon/presentation/bloc/weather_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:etalon/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetWeatherRepositoryUseCase,
    Dio],
  // customMocks: [MockSpec<http.Client>(as: #MockHttpClient)]
)
void main() {}
