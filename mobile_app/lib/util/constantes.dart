import 'package:flutter/material.dart';


Color colorPrimary = Color(0xffffca27);
Color colorPrimaryAccent = Color(0xffff6230);
Color colorText = Color(0xff212a37);
Color colorBackground = Color(0xfffbf9f7);

//android emulator ip 10.0.2.2
//genymotion emulator ip 

class Constantes{
  static const String WEATHER_FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast?q=Luanda,ao&units=metric&APPID=50dd93c6b8d5aed5e9495c45b70c3fe8";
  static const String WEATHER_ICONS_URL = "http://openweathermap.org/img/wn/10d@2x.png";
  static const String BASE_URL_API = "http://10.0.2.2/api-juber/public/api";
  static const String BASE_URL_IMAGE = "http://10.0.2.2/api-juber/public";

  static String iconUrlWeather(String iconName){
    return "http://openweathermap.org/img/wn/$iconName@2x.png";
  }

  static String dataFormato1(DateTime data){
    String dataFormatada = "${data.day} ";
    switch (data.month) {
      case 1: dataFormatada += "Jan ";        
        break;
      case 2: dataFormatada += "Fev ";        
        break;
      case 3: dataFormatada += "Mar ";        
        break;
      case 4: dataFormatada += "Abr ";        
        break;
      case 5: dataFormatada += "Mai ";        
        break;
      case 6: dataFormatada += "Jun ";        
        break;
      case 7: dataFormatada += "Jul ";        
        break;
      case 8: dataFormatada += "Ago ";        
        break;
      case 9: dataFormatada += "Set ";        
        break;
      case 10: dataFormatada += "Out ";        
        break;
      case 11: dataFormatada += "Nov ";        
        break;
      case 12: dataFormatada += "Dez ";        
        break;
      default:
    }
    dataFormatada += "${data.year}";
    return dataFormatada;
  }
}