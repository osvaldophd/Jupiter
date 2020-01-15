import 'dart:async';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/resource/data.dart';

class AuthRepository{

  ApiProvider _apiProvider = ApiProvider();

  Future<AuthModel> login(String email, String senha) =>
      _apiProvider.login(email, senha);

  Future<PerfilModel> getPerfil() =>
      _apiProvider.getPerfil();

}