import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobile_app/model/models.dart';
import 'dart:async';

import 'package:mobile_app/repositories/repositories.dart';

class AuthBloc extends BlocBase{

  PerfilModel previousPerfil;
  final authRepository = AuthRepository();

  StreamController<PerfilModel> _controllerPerfil = StreamController<PerfilModel>.broadcast();
  Stream<PerfilModel> get outPerfil => _controllerPerfil.stream;

  Future<AuthModel> login(String email, String senha) async{
    return await authRepository.login(email, senha);
  }

  Future<void> getPerfils() async{
    return authRepository.getPerfil().then((perfils) {
      if(perfils.status){
        previousPerfil = perfils;
        _controllerPerfil.sink.add(perfils);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerPerfil.close();
  }

}