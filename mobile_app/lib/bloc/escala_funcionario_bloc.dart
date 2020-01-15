
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/repositories/escala_funcionario_repository.dart';
import 'dart:async';


class EscalaFuncionarioBloc extends BlocBase{

  final escalaFuncionarioRepository = EscalaFuncionarioRepository();

  
  EscalaFuncionarioModel previousEscalaFuncionarios;

  StreamController<EscalaFuncionarioModel> _controllerEscalaFuncionario = StreamController<EscalaFuncionarioModel>.broadcast();
  Stream<EscalaFuncionarioModel> get outEscalaFuncionario => _controllerEscalaFuncionario.stream;

  Future<void> getEscalaFuncionarios() async{
    return escalaFuncionarioRepository.getEscalaFuncionarios().then((escala) {
      if(escala.status){
        previousEscalaFuncionarios = escala;
        _controllerEscalaFuncionario.sink.add(escala);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerEscalaFuncionario.close();
  }

}