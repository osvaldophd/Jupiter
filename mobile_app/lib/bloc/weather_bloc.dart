import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobile_app/model/models.dart';
import 'dart:async';

import 'package:mobile_app/repositories/repositories.dart';

class WeatherBloc extends BlocBase{

  final WeatherRepository _weatherRepository = WeatherRepository();

  WeatherForecast downloadedWeather;

  StreamController<WeatherForecast> _controllerWForecast = StreamController<WeatherForecast>.broadcast();
  Stream<WeatherForecast> get outWForecast => _controllerWForecast.stream;

  Future<void> getWeatherForecast(){
    return _weatherRepository.getWeatherForecast().then((forecast) {
      if(forecast.exito){
        downloadedWeather = forecast;
        _controllerWForecast.sink.add(forecast);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerWForecast.close();
  }

}