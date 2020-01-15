import 'dart:async';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/resource/data.dart';

class VanRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<VanModel> getVans() => _apiProvider.getVans();

  Future<VanMatriculaModel> getVanMatricula(String matricula) 
    => _apiProvider.getVanMatricula(matricula);
}