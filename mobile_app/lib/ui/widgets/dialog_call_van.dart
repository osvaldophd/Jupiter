import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:url_launcher/url_launcher.dart';


class DialogCallVan extends StatefulWidget {

  List<Contacto> listaContactos;
  DialogCallVan(this.listaContactos);
  
  @override
  _DialogCallVanState createState() => _DialogCallVanState();

}

class _DialogCallVanState extends State<DialogCallVan> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: contactos(widget.listaContactos),
        )
      )
    );
  }

  List<Widget> contactos(List<Contacto> listaContactos){
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
                      Icon(SimpleLineIcons.getIconData("phone"), color: colorPrimaryAccent,),
                      SizedBox(width: 20,),
                      InkWell(
                        child: Text(f.contacto),
                        onTap: () => _launchPhone(f.contacto),
                      ),
                    ]
                  )
                ),
                onTap: () {
                  Navigator.of(context).pop();
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
      return lista;
    }               

  _launchPhone(String phone) async {
    var url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}