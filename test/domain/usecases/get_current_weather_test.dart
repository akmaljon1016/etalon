import 'package:dartz/dartz.dart';
import 'package:etalon/domain/entities/weather.dart';
import 'package:etalon/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWeatherRepositoryUseCase getWeatherRepositoryUseCase;
  late MockWeatherRepository mockWeatherRepository;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getWeatherRepositoryUseCase =
        GetWeatherRepositoryUseCase(weatherRepository: mockWeatherRepository);
  });

  const weatherDetail = WeatherEntity(
      cityName: 'New York',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const testCityName = "New York";
  test('should get current weather detail from the repository', () async {
    //arrange

    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async =>  const Right(weatherDetail));
    //act
    final result =
        await getWeatherRepositoryUseCase.call(cityName: testCityName);
    //assert
    expect(result,  const Right(weatherDetail));
  });
}
