import 'dart:async';
import 'package:mobile_app/model/escala_funcionario_model.dart';
import 'package:mobile_app/resource/data.dart';

class EscalaFuncionarioRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<EscalaFuncionarioModel> getEscalaFuncionarios() => _apiProvider.getEscalaFuncionarios();
}