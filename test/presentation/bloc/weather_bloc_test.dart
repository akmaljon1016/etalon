import 'package:dartz/dartz.dart';
import 'package:etalon/core/error/failure.dart';
import 'package:etalon/domain/entities/weather.dart';
import 'package:etalon/presentation/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetWeatherRepositoryUseCase mockGetWeatherRepositoryUseCase;
  late WeatherBloc weatherBloc;
  setUp(() {
    mockGetWeatherRepositoryUseCase = MockGetWeatherRepositoryUseCase();
    weatherBloc = WeatherBloc(mockGetWeatherRepositoryUseCase);
  });

  const testWeather = WeatherEntity(
      cityName: 'New York',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const testCity = "New York";

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherInitial());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading,WeatherLoaded] when data is gotten',
    build: () {
      when(mockGetWeatherRepositoryUseCase.call(cityName: testCity))
          .thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (bloc) {
      bloc.add(OnCityChanged(testCity));
    },
    wait: const Duration(milliseconds: 500),
    expect: () => <WeatherState>[WeatherLoading(), WeatherLoaded(testWeather)],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading,WeatherLoadedFailure] when data is unsuccessful',
    build: () {
      when(mockGetWeatherRepositoryUseCase.call(cityName: testCity))
          .thenAnswer((_) async => const Left(ServerFailure("server error")));
      return weatherBloc;
    },
    act: (bloc) {
      bloc.add(OnCityChanged(testCity));
    },
    wait: const Duration(milliseconds: 500),
    expect: () =>
        <WeatherState>[WeatherLoading(), WeatherLoadFailure("server error")],
  );
}


