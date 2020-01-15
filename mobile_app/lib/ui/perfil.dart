import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:mobile_app/bloc/auth_bloc.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/ui/widgets/dialog_save_contact.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:image_picker/image_picker.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

  List<ContactoFuncionario> contactos;
  final AuthBloc _authBloc = BlocProvider.getBloc<AuthBloc>();
  final FuncionarioBloc _funcionarioBloc = BlocProvider.getBloc<FuncionarioBloc>();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtNacionalidade = TextEditingController();
  TextEditingController txtDataNascimento = TextEditingController();
  TextEditingController txtNumBi = TextEditingController();
  File _imagem;
  int idUser;
  var _generoValue;
  DateTime _selectedDate;
  bool firstBinding;
  bool salvando;
  
  @override
  void initState() {
    super.initState();
    salvando = false;
    _generoValue = "Masculino";
    firstBinding = true;
    _authBloc.getPerfils();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: StreamBuilder<PerfilModel>(
        stream: _authBloc.outPerfil,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            var perfil = snapshot.data;
            idUser = perfil.funcionario.id;
            if(firstBinding){
              print("receiv data");
              firstBinding = false;
              _selectedDate = perfil.funcionario.dataNascimento;
              txtNome.text = perfil.funcionario.nome;
              txtNacionalidade.text = perfil.funcionario.nacionalidade;
              txtDataNascimento.text = DateFormat('dd-MM-yyyy')
                                  .format(perfil.funcionario.dataNascimento);
              txtNumBi.text = perfil.funcionario.nrBi;
              _generoValue = perfil.funcionario.genero == 'M' ? "Masculino" : "Feminino";
            }
            return buildPerfilFields(perfil);

          } else if(_authBloc.previousPerfil != null){

            if(firstBinding){
              print("receiv data");
              firstBinding = false;
              _selectedDate = _authBloc.previousPerfil.funcionario.dataNascimento;
              txtNome.text = _authBloc.previousPerfil.funcionario.nome;
              txtNacionalidade.text = _authBloc.previousPerfil.funcionario.nacionalidade;
              txtDataNascimento.text = DateFormat('dd-MM-yyyy')
                                  .format(_authBloc.previousPerfil.funcionario.dataNascimento);
              txtNumBi.text = _authBloc.previousPerfil.funcionario.nrBi;
              _generoValue = _authBloc.previousPerfil.funcionario.genero == 'M' ? "Masculino" : "Feminino";
            }
            return buildPerfilFields(_authBloc.previousPerfil);
            
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
  
  Widget buildPerfilFields(PerfilModel perfil){
    contactos = perfil.funcionario.contactos;
    return ListView(
      children: <Widget>[

        Container(
          height: 150,
          child: Center(
            child: Container(
              height: 100,
              width: 100,
              child: InkWell(
                child: CircleAvatar(
                  backgroundImage: _imagem == null ?
                  NetworkImage("${Constantes.BASE_URL_IMAGE}${perfil.funcionario.imagem}",) :
                  _imagem != null ? 
                  FileImage(_imagem)
                  : AssetImage(
                    "assets/images/amarildo.png",
                  )
                ),
                onTap: () => _openImagePickerModal(context),
              ),
            ),
          ),
        ),
 
        Text("Dados Pessoais", style: 
          TextStyle(color: colorText, fontSize: 18, fontWeight: FontWeight.w200),
        ),
        Divider(height: 5, color: colorPrimaryAccent,),
        
        SizedBox(height: 20,),
        
        Text("Nome", style: 
          TextStyle(color: colorText, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: txtNome,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),

        SizedBox(height: 20,),

        Text("Nacionalidade", style: 
          TextStyle(color: colorText, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: txtNacionalidade,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),

        SizedBox(height: 20,),

        Text("Género", style: 
          TextStyle(color: colorText, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio(
                  value: "Masculino",
                  groupValue: _generoValue,
                  onChanged: (value) {
                    setState(() {
                      _generoValue = value;
                    });
                  },
                ),
                Text('Masculino'),
              ]
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: "Feminino",
                  groupValue: _generoValue,
                  onChanged: (value) {
                    setState(() {
                      _generoValue = value;
                    });
                  },
                ),
                Text('Feminino'),
              ]
            ),
          ],
        ),
      
        SizedBox(height: 20,),

        Text("Data de nascimento", style: 
          TextStyle(color: colorText, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: txtDataNascimento,
          decoration: InputDecoration(
            border: OutlineInputBorder(), 
            suffixIcon: InkWell(
              child: Icon(SimpleLineIcons.getIconData("calendar")),
              onTap: () => _selectDate(),
            )
          ),
        ),

        SizedBox(height: 20,),

        Text("Num. Identificação", style: 
          TextStyle(color: colorText, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: txtNumBi,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),

        SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Contactos", style: 
              TextStyle(color: colorText, fontSize: 18, fontWeight: FontWeight.w200),
            ),
            IconButton(
              icon: Icon(SimpleLineIcons.getIconData("plus")),
              onPressed: () async{
                ContactoFuncionario contactoAdd= await showDialog(
                  context: context,
                  builder: (context) {
                    return  DialogSaveContact('add');
                });
                if(contactoAdd != null){
                  setState(() {
                    contactos.add(contactoAdd); 
                  });
                }
              },
            )
          ],
        ),
        Divider(height: 5, color: colorPrimaryAccent,),
        
        SizedBox(height: 20,),

        Column(
          children: buildContactItem()
        ),

        SizedBox(height: 40,),

        RaisedButton(
          color: colorPrimaryAccent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: salvando ? 
              Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
              :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesome.getIconData("save"), color: Colors.white,),
                  SizedBox(width: 10,),
                  Text("Salvar", 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 18, 
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
          ),
          onPressed: () {
            updateUser();
          },
        ),

        SizedBox(height: 20,),

      ],
    );
          
  }

  List<Widget> buildContactItem(){
    List<Widget> listaRetorno = [];
    contactos.forEach((f) {
      listaRetorno.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Text(f.contacto),
              onTap: () async {
                ContactoFuncionario contactoAlterado = await showDialog(
                  context: context,
                  builder: (context) {
                    return DialogSaveContact('update', contacto: f);
                });
                if(contactoAlterado != null){
                  var index = contactos.indexWhere((x) => x.id == contactoAlterado.id);
                  setState(() {
                    print("up");
                    contactos[index] = contactoAlterado;
                  });
                }
              },
            ),
            Text(f.tipo),
            IconButton(
              icon: Icon(SimpleLineIcons.getIconData("trash"), color: Colors.red,),
              onPressed: () => print("delete contact"),
            )
          ],
        )
      );
    });
    return listaRetorno;
  }

  updateUser() async{
    setState(() {
      salvando = true;
    });
    String base64Imagem;
    if(_imagem != null){
      final mimeTypeData = lookupMimeType(_imagem.path, headerBytes: [0xFF, 0xD8]).split('/');
      base64Imagem = "data:${mimeTypeData[0]}/${mimeTypeData[1]};base64,";
      mimeTypeData.forEach((f){
        print(f);
      });
      List<int> imageBytes = await _imagem.readAsBytes();
      base64Imagem += base64Encode(imageBytes);
    }
    var user = UpdateUserModel(
      nome: txtNome.text,
      usuarioId: idUser,
      nacionalidade: txtNacionalidade.text,
      dataNascimento: _selectedDate,
      genero: _generoValue == "Masculino" ? "M" : "F",
      nrBi: txtNumBi.text,
      imagem: _imagem != null ? base64Imagem : null,
      contactos: contactos
    );
    _funcionarioBloc.updatePerfil(user).then((result){
      if(result.status){
        print(result.status);
        setState(() {
          salvando = false;
        });
        _authBloc.getPerfils();
      } else {
        print("nao salvou");
      }
    });
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now()
    );
    if(picked != null) setState(() {
      _selectedDate = picked;
      txtDataNascimento.text = DateFormat('dd-MM-yyyy').format(picked);
    });
  }

  Future getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _imagem = image;
    });
  }

  void _openImagePickerModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Selecionar imagem',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: colorText,
                  child: Text('Camara'),
                  onPressed: () async{
                    await getImage(context, ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  textColor: colorText,
                  child: Text('Galeria'),
                  onPressed: () async{
                    await getImage(context, ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

}