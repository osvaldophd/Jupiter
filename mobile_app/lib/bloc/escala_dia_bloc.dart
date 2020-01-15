import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobile_app/model/models.dart';
import 'dart:async';

import 'package:mobile_app/repositories/repositories.dart';

class EscalaDiaBloc extends BlocBase{

  final escalaDiaRepository = EscalaDiaRepository();

  
  EscalaDiaModel previousEscalaDia;
  EscalaDiaModel previousEscalaHoje;

  StreamController<EscalaDiaModel> _controllerEscalaDia = StreamController<EscalaDiaModel>.broadcast();
  Stream<EscalaDiaModel> get outEscalaDia => _controllerEscalaDia.stream;

  StreamController<EscalaDiaModel> _controllerEscalaHoje = StreamController<EscalaDiaModel>.broadcast();
  Stream<EscalaDiaModel> get outEscalaHoje => _controllerEscalaHoje.stream;

  Future<void> getEscalaHoje() async{
    return escalaDiaRepository.getEscalaHoje().then((escala) {
      if(escala.status){
        previousEscalaHoje = escala;
        _controllerEscalaHoje.sink.add(escala);
      }
    });
  }

  Future<void> getEscalaDia(int dia) async{
    return escalaDiaRepository.getEscalaDia(dia).then((escala) {
      if(escala.status){
        previousEscalaDia = escala;
        _controllerEscalaDia.sink.add(escala);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerEscalaDia.close();
    _controllerEscalaHoje.close();
  }

}