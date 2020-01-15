import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobile_app/model/models.dart';
import 'dart:async';

import 'package:mobile_app/repositories/repositories.dart';

class FuncionarioBloc extends BlocBase{

  final funcionarioRepository = FuncionarioRepository();
  FuncionarioModel previousFuncionarios;

  StreamController<FuncionarioModel> _controllerFuncionario = StreamController<FuncionarioModel>.broadcast();
  Stream<FuncionarioModel> get outFuncionario => _controllerFuncionario.stream;

  Future<void> getFuncionarios() async{
    return funcionarioRepository.getFuncionarios().then((funcionarios) {
      if(funcionarios.status){
        previousFuncionarios = funcionarios;
        _controllerFuncionario.sink.add(funcionarios);
      }
    });
  }

  Future <UpdateUserResponseModel> updatePerfil(UpdateUserModel userModel){
    return funcionarioRepository.updatePerfil(userModel);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerFuncionario.close();
  }

}