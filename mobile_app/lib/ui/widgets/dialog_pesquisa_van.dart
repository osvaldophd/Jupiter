import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DialogPesquisaVan extends StatefulWidget {
  
  @override
  _DialogPesquisaVanState createState() => _DialogPesquisaVanState();

}

class _DialogPesquisaVanState extends State<DialogPesquisaVan> {

  final VanBloc _vanBloc = BlocProvider.getBloc<VanBloc>();
  TextEditingController txtMatricula = TextEditingController();
  bool achouMatricula;
  VanMatriculaModel _vanMatriculaModel;
  String matriculaActual;

  @override
  void initState() {
    super.initState();
    achouMatricula = false;
  }

  void updateMatriculaActual(){
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        matriculaActual = prefs.getString("matricula");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    updateMatriculaActual();
    return Dialog(
      backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          width: 400,
          // height: 455,
          decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Adicionar Van ao Dispositivo",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                // Text(
                //   "Informe a matrícula da van para conectar o telemovel a ela, e obter a localizacao por meio dele",
                //   textAlign: TextAlign.center,
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                
                Text("Van actual: $matriculaActual",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),

                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: txtMatricula,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Insira a matricula',
                    hintStyle: TextStyle(color: colorText),
                  ),
                  onSubmitted: (s) => findMatricula(),
                ),

                SizedBox(height: 15,),

                // Center(
                //   child: achouMatricula ?
                //     Icon(FontAwesome.getIconData("check"), color: Colors.green,):
                //     Icon(FontAwesome.getIconData("close"), color: Colors.red,),
                // ),                
                  
                // SizedBox(height: 5,),

                achouMatricula ?
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesome.getIconData("check"), color: Colors.green),
                    Text("${_vanMatriculaModel.van[0].modelo.nome} - ${_vanMatriculaModel.van[0].modelo.marca.nome}",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    )
                  ],
                ) :
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesome.getIconData("close"), color: Colors.red),
                    Text("Matricula nao encontrada",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        txtMatricula.clear();
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          color: achouMatricula ? Colors.blueAccent : Colors.grey,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        if(achouMatricula) salvarMatricula();
                      },
                    )
                  ],
                )

              ],
            ),
            
      )
    );
  }

    findMatricula(){
    _vanBloc.getVanMatricula1(txtMatricula.text).then((van){
      setState(() {
        achouMatricula = van.status;
        print(achouMatricula);
        if(achouMatricula){
          _vanMatriculaModel = van;
        }
      });
    });
  }

  salvarMatricula(){
    SharedPreferences.getInstance().then((prefs) {
      Van van = _vanMatriculaModel.van[0];
      prefs.setString("matricula", van.matricula);
      prefs.setString("marca", van.modelo.marca.nome);
      prefs.setString("modelo", van.modelo.nome);
      prefs.setString("imagem", van.imagem);
      prefs.setString("lugares", van.nrOcupantes.toString());
      Navigator.pop(context);
    });
  }

}