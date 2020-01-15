import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mobile_app/model/models.dart';
import 'dart:async';

import 'package:mobile_app/repositories/repositories.dart';

class VanBloc extends BlocBase{

  final vanRepository = VanRepository();
  
  VanModel previousVans;
  StreamController<VanModel> _controllerVan = StreamController<VanModel>.broadcast();
  Stream<VanModel> get outVan => _controllerVan.stream;

  VanMatriculaModel previousVanMatricula;
  StreamController<VanMatriculaModel> _controllerVanMatricula = StreamController<VanMatriculaModel>.broadcast();
  Stream<VanMatriculaModel> get outVanMatricula => _controllerVanMatricula.stream;


  Future<void> getVans() async{
    return vanRepository.getVans().then((vans) {
      if(vans.status){
        previousVans = vans;
        _controllerVan.sink.add(vans);
      }
    });
  }

  Future<VanMatriculaModel> getVanMatricula1(String matricula) {
    return vanRepository.getVanMatricula(matricula);
  }

  Future<void> getVanMatricula2(String matricula) async{
    return vanRepository.getVanMatricula(matricula).then((vans) {
      if(vans.status){
        previousVanMatricula = vans;
        _controllerVanMatricula.sink.add(vans);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerVan.close();
    _controllerVanMatricula.close();
  }
}