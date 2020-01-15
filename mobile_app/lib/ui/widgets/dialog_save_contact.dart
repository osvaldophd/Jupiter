import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/model/funcionario_model.dart';
import 'package:mobile_app/util/constantes.dart';

class DialogSaveContact extends StatefulWidget {
  
  ContactoFuncionario contacto;
  String operacao;

  DialogSaveContact(this.operacao,{this.contacto});

  @override
  _DialogSaveContactState createState() => _DialogSaveContactState();
}

class _DialogSaveContactState extends State<DialogSaveContact> {

  TextEditingController txtContacto = TextEditingController();
  String _tipoValue;

  @override
  void initState() { 
    super.initState();
    txtContacto.text = widget.operacao=='update' ? widget.contacto.contacto:'';
    _tipoValue = widget.operacao=='update' ? widget.contacto.tipo : null;
  }

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            SizedBox(height: 20,),

            Text("Contacto", 
            textAlign: TextAlign.start,
              style: TextStyle(color: colorText, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            TextField(
              controller: txtContacto,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20,),

            Text("Tipo", 
            textAlign: TextAlign.start,
              style: TextStyle(color: colorText, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            DropdownButtonFormField<String>(
              value: _tipoValue,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: <String>['telemovel', 'email'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) { 
                setState(() {
                  _tipoValue = value; 
                });
              },
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
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if(widget.operacao=='update'){
                      widget.contacto.contacto = txtContacto.text;
                      widget.contacto.tipo = _tipoValue;
                    } else if(widget.operacao=='add'){
                      widget.contacto = ContactoFuncionario(
                        contacto: txtContacto.text, 
                        tipo: _tipoValue
                      );
                    }
                    Navigator.pop(context, widget.contacto);
                  },
                )
              ],
            )


          ],
        )
      )
    );
    
  }
}