part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

final class FetchWeather extends WeatherEvent {}