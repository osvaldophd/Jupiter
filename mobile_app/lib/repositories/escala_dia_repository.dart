import 'dart:async';
import 'package:mobile_app/model/escala_dia_model.dart';
import 'package:mobile_app/resource/data.dart';

class EscalaDiaRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<EscalaDiaModel> getEscalaHoje() => _apiProvider.getEscalaHoje();

  Future<EscalaDiaModel> getEscalaDia(int dia) => _apiProvider.getEscalaDia(dia);

}