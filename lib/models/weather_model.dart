// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  /*
    final data = snapshot.data!;

    final currentWeatherData = data['list'][0];

    final currentTemp = currentWeatherData['main']['temp'];
    final currentSky = currentWeatherData['weather'][0]['main'];
    final currentPressure = currentWeatherData['main']['pressure'];
    final currentWindSpeed = currentWeatherData['wind']['speed'];
    final currentHumidity = currentWeatherData['main']['humidity']; 
  */

  final num currentTemp;
  final String currentSky;
  final num currentPressure;
  final num currentWindSpeed;
  final num currentHumidity;
  final List<HourlyForcast> hourlyForecast;
  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecast,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    double? currentPressure,
    double? currentWindSpeed,
    double? currentHumidity,
  }) {
    return WeatherModel(
        currentTemp: currentTemp ?? this.currentTemp,
        currentSky: currentSky ?? this.currentSky,
        currentPressure: currentPressure ?? this.currentPressure,
        currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
        currentHumidity: currentHumidity ?? this.currentHumidity,
        hourlyForecast: hourlyForecast);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyForecast': hourlyForecast
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    // final hourlyForecast = map['list'][1];
    // final hourlySky = map['list'][1]['weather'][0]['main'];

    List<HourlyForcast> forcast = [];

    for (int i = 0; i < 5; i++) {
      forcast.add(HourlyForcast(
        time: DateTime.parse(map['list'][i+1]['dt_txt']),
        temp: map['list'][i+1]['main']['temp'],
        sky: map['list'][i + 1]['weather'][0]['main'],
      ));
    }
    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'] as num,
      currentSky: currentWeatherData['weather'][0]['main'] as String,
      currentPressure: currentWeatherData['main']['pressure'] as num,
      currentWindSpeed: currentWeatherData['wind']['speed'] as num,
      currentHumidity: currentWeatherData['main']['humidity'] as num,
      hourlyForecast: forcast
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode;
  }
}

class HourlyForcast {
  final DateTime time;
  final num temp;
  final String sky;
  HourlyForcast({
    required this.time,
    required this.temp,
    required this.sky,
  });

  HourlyForcast copyWith({
    DateTime? time,
    num? temp,
    String? sky,
  }) {
    return HourlyForcast(
      time: time ?? this.time,
      temp: temp ?? this.temp,
      sky: sky ?? this.sky,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'temp': temp,
      'sky': sky,
    };
  }

  factory HourlyForcast.fromMap(Map<String, dynamic> map) {
    return HourlyForcast(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      temp: map['temp'] as num,
      sky: map['sky'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyForcast.fromJson(String source) =>
      HourlyForcast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HourlyForcast(time: $time, temp: $temp, sky: $sky)';

  @override
  bool operator ==(covariant HourlyForcast other) {
    if (identical(this, other)) return true;

    return other.time == time && other.temp == temp && other.sky == sky;
  }

  @override
  int get hashCode => time.hashCode ^ temp.hashCode ^ sky.hashCode;
}
