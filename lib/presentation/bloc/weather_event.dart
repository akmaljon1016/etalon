part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent extends Equatable {}

class OnCityChanged extends WeatherEvent {
  final String cityName;

  OnCityChanged(this.cityName);

  @override
  List<Object> get props => [cityName];
}
