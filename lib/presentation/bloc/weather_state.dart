part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

 class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

 class WeatherLoaded extends WeatherState {
  final WeatherEntity result;

  WeatherLoaded(this.result);

  @override
  List<Object> get props => [result];
}

 class WeatherLoadFailure extends WeatherState {
  final String message;

  WeatherLoadFailure(this.message);

  @override
  List<Object> get props => [message];
}
