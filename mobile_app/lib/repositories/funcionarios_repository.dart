import 'dart:async';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/resource/data.dart';

class FuncionarioRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<FuncionarioModel> getFuncionarios() => _apiProvider.getFuncionarios();

  Future<UpdateUserResponseModel> updatePerfil(UpdateUserModel userModel) 
            => _apiProvider.updatePerfil(userModel); 
}