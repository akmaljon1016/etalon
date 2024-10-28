import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:etalon/domain/entities/weather.dart';
import 'package:etalon/domain/usecases/get_current_weather.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherRepositoryUseCase getWeatherRepositoryUseCase;

  WeatherBloc(this.getWeatherRepositoryUseCase) : super(WeatherInitial()) {
    on<OnCityChanged>((event, emit) async {
      emit(WeatherLoading());
      final result =
      await getWeatherRepositoryUseCase.call(cityName: event.cityName);
      result.fold((failure) {
        emit(WeatherLoadFailure(failure.message));
      }, (data) {
        emit(WeatherLoaded(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap((mapper));
  }
}