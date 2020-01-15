import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_app/model/funcionario_model.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogMenuMotorista extends StatefulWidget {
  List<ContactoFuncionario> listaContactos;
  DialogMenuMotorista(this.listaContactos);
  @override
  _DialogMenuMotoristaState createState() => _DialogMenuMotoristaState();
}

class _DialogMenuMotoristaState extends State<DialogMenuMotorista> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          width: 400,
          // height: 455,
          decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: internContentChamadaFun(widget.listaContactos),
      )
    );
  }


     
  Widget internContentChamadaFun(List<ContactoFuncionario> listaContactos){
      List<Widget> lista = [];
      listaContactos.forEach((f) {
        lista.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        f.tipo == 'telemovel' ? SimpleLineIcons.getIconData("phone") :  
                        f.tipo == 'telefone' ? SimpleLineIcons.getIconData("phone") :  
                        f.tipo == 'email' ? SimpleLineIcons.getIconData("envelope-open") : 
                        SimpleLineIcons.getIconData("phone")  , 
                        color: colorPrimaryAccent,
                      ),
                      SizedBox(width: 20,),
                      Text(f.contacto),
                    ]
                  )
                ),
                onTap: () {
                  _launchPhone(f.contacto, f.tipo);
                },),
            ),
          )
        );
      });
      if(lista.length == 0){
        lista.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Sem contactos"),
          )
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: lista 
      );                  
    }


  _launchPhone(String contact, String tipo) async {
    if(tipo == 'email'){
      var url = 'mailto:$contact';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }else{
      var url = 'tel:$contact';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    
  }

}