import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:etalon/domain/entities/weather.dart';
import 'package:etalon/presentation/bloc/weather_bloc.dart';
import 'package:etalon/presentation/page/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;
  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  const testWeatherEntity = WeatherEntity(
      cityName: 'Fergana',
      main: 'Clear',
      description: 'clear sky',
      iconCode: '01d',
      temperature: 300.24,
      pressure: 1014,
      humidity: 19);

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'text field should trigger state to change from empty to loading ',
      (widgetTester) async {
    //arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherInitial());
    //act
    await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await widgetTester.enterText(textField, "New York");
    await widgetTester.pump();
    expect(find.text('New York'), findsOneWidget);
  });

  testWidgets('should show progress when state is loading',
      (widgetTester) async {
    //arrange
    when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());
    //act
    await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should show widget contain weather data when  state is weather loaded',
      (widgetTester) async {
    await widgetTester.runAsync(() async {
      //arrange
      when(() => mockWeatherBloc.state)
          .thenReturn(WeatherLoaded(testWeatherEntity));
      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
      expect(find.byKey(const Key('weather_data')), findsOneWidget);
    });
  });
}
