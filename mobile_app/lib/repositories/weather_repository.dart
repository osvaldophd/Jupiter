import 'dart:async';
import 'package:mobile_app/model/weather_forecast.dart';
import 'package:mobile_app/resource/data.dart';

class WeatherRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<WeatherForecast> getWeatherForecast() => _apiProvider.weatherForecast();
}