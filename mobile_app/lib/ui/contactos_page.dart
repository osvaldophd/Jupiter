
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:mobile_app/model/funcionario_model.dart';
import 'package:mobile_app/ui/widgets/dialog_menu_motorista.dart';
import 'package:mobile_app/util/constantes.dart';

class ContactosPage extends StatefulWidget {
  @override
  _ContactosPageState createState() => _ContactosPageState();
}

class _ContactosPageState extends State<ContactosPage> {

  
  final VanBloc _vanBloc = BlocProvider.getBloc<VanBloc>();
  final FuncionarioBloc _funcionarioDiaBloc = BlocProvider.getBloc<FuncionarioBloc>();

  TextEditingController txtSearch = TextEditingController();
  String search = "";

  @override
  void initState() {
    super.initState();
    _vanBloc.getVans();
    _funcionarioDiaBloc.getFuncionarios();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

//-----------------------------Search Box---------------------------------------
          Container(
            height: 60,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: colorPrimary,
            ),
            child: Center(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: colorBackground,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: colorBackground)
                ),
                child: TextField(
                  controller: txtSearch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Container(
                      decoration: BoxDecoration(                     
                        color: colorBackground,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), topLeft: Radius.circular(30)),
                      ),
                      child: Icon(SimpleLineIcons.getIconData("magnifier"), color: colorText,)
                    ),
                    hintText: 'Pesquisar',
                    hintStyle: TextStyle(color: colorText),
                    suffixIcon: Container(
                      decoration: BoxDecoration(                     
                        color: colorBackground,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
                      ),
                      child: InkWell(
                        child: Icon(SimpleLineIcons.getIconData("close"), color: colorText,),
                        onTap: () => txtSearch.clear()
                      )
                    ),
                  ), 
                  onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                ),
              ),
            ),
          ),

//----------------------------Contact List Motoristas--------------------------------------
          Expanded(
            child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: colorBackground,
            ),
            child: ListView(
                children: <Widget>[

                  // Padding(
                  //   padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10,),
                  //   child: Text("MOTORISTAS", style: TextStyle(fontSize: 12)),
                  // ),
                  StreamBuilder<FuncionarioModel>(
                    stream: _funcionarioDiaBloc.outFuncionario,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return buildFuncionariosList(snapshot.data);
                      } else if(_funcionarioDiaBloc.previousFuncionarios != null){
                        return buildFuncionariosList(_funcionarioDiaBloc.previousFuncionarios);
                      } else{
                        return Center(child: CircularProgressIndicator(),);
                      }                      
                    }
                  ),

//       //----------------------------Contact List Logistica--------------------------------------
//                   SizedBox(height: 10,),
//                   Padding(
//                     padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10,),
//                     child: Text("LOGÍSTICA", style: TextStyle(fontSize: 12)),
//                   ),
                  
// //----------------------------Contact List Logistica--------------------------------------
//                   SizedBox(height: 10,),
//                   Padding(
//                     padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10,),
//                     child: Text("FÁBRICA", style: TextStyle(fontSize: 12)),
//                   ),
//                   SizedBox(height: 50,),

                ],
              ),
            ),
          )
          

        ],
      ),
    );
  }



  Widget buildFuncionariosList(FuncionarioModel funcionarioModel){
    List<Funcionario> listaCompleta = funcionarioModel.data.funcionarios;
    List<Funcionario> lista = [];
    if (txtSearch.text.isEmpty) {
      lista = listaCompleta;
    } else {
      listaCompleta.forEach((x) {
        if (x.nome.toLowerCase().contains(search.toLowerCase()) ||
            x.nacionalidade.toLowerCase().contains(search.toLowerCase())) {
          lista.add(x);
        }
      });
    }
    lista.sort((a, b) {
      return a.nome.toLowerCase().compareTo(b.nome.toLowerCase());
    });
    if(lista.length > 0){
      return ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: lista.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index)  {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            leading: CircleAvatar(
              backgroundImage: NetworkImage("${Constantes.BASE_URL_IMAGE}${lista[index].imagem}",),
            ),
            title: Text(
              lista[index].nome, 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(SimpleLineIcons.getIconData("star")),
            subtitle: Text("Nacionalidade: ${lista[index].nacionalidade}\nGenero: ${lista[index].genero == 'M' ? 'Masculino' : 'Feminino'}"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogMenuMotorista(lista[index].contactos);
                });
              
            },
          );
        },
      );
    } else {
      return Center(
        child: Text("Lista vazia."),
      );
    }    
  }

 void dialogMenuContacto(int idFuncionario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          content: StreamBuilder<FuncionarioModel>(
            stream: _funcionarioDiaBloc.outFuncionario,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return DialogMenuMotorista(snapshot.data.data.funcionarios.
                  singleWhere((test) => test.id == idFuncionario).contactos);
              } else if(_funcionarioDiaBloc.previousFuncionarios != null) {
                return DialogMenuMotorista(_funcionarioDiaBloc.previousFuncionarios
                  .data.funcionarios.singleWhere((test) => test.id == idFuncionario)
                  .contactos);
              } else {
                return Container(
                  child: Center(child: CircularProgressIndicator(),),
                );
              }
            }
          )
          
        );
      }
    );
  }

}