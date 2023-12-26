import 'dart:convert';
import 'package:weatherbloc/data/data_provider/weather_data_provider.dart';
import 'package:weatherbloc/keys.dart';
import 'package:weatherbloc/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      final weatherData = await weatherDataProvider.getCurrentWeather(location);
      final data = jsonDecode(weatherData);
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return WeatherModel.fromJson(weatherData);
    } catch (e) {
      throw e.toString();
    }
  }
}
