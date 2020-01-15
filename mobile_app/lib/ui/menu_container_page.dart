import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:background_location/background_location.dart';
import 'package:mobile_app/bloc/auth_bloc.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/ui/Mapa.dart';
import 'package:mobile_app/ui/agenda_page.dart';
import 'package:mobile_app/ui/contactos_page.dart';
import 'package:mobile_app/ui/feedback_page.dart';
import 'package:mobile_app/ui/home_page.dart';
import 'package:mobile_app/ui/login_page.dart';
import 'package:mobile_app/ui/perfil.dart';
import 'package:mobile_app/ui/widgets/dialog_pesquisa_van.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuContainerPage extends StatefulWidget {
  @override
  _MenuContainerPageState createState() => _MenuContainerPageState();
}

class _MenuContainerPageState extends State<MenuContainerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String selectedMenu = 'home';
  String backgroudType = 'padrao';
  final AuthBloc _authBloc = BlocProvider.getBloc<AuthBloc>();

  @override
  void initState() {
    super.initState();
    _authBloc.getPerfils();
    selectedMenu = 'home';
    backgroudType = 'padrao';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor:
            backgroudType == 'padrao' ? colorBackground : colorPrimary,
        //------------------------------AppBar--------------------------
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor:
              backgroudType == 'padrao' ? colorPrimary : colorBackground,
          leading: IconButton(
            icon: Icon(
              SimpleLineIcons.getIconData('menu'),
              color: backgroudType == 'padrao' ? colorBackground : colorText,
              size: 28,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        //------------------------------Menu Drawer--------------------------
        drawer: Container(
            color: colorPrimary,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  
                  StreamBuilder<PerfilModel>(
                    stream: _authBloc.outPerfil,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return menuHeader(snapshot.data);
                      }else if(_authBloc.previousPerfil != null){
                        return menuHeader(_authBloc.previousPerfil);
                      }else{
                        return menuHeader(null);
                      }
                    },
                  ),

                  StreamBuilder<PerfilModel>(
                    stream: _authBloc.outPerfil,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return buildMenu(snapshot.data);
                      }else if(_authBloc.previousPerfil != null){
                        return buildMenu(_authBloc.previousPerfil);
                      }else{
                        return buildMenu(null);
                      }
                    },
                  ),

                  ],
              ),
            )),
        //------------------------------Main Content--------------------------
        body: selectedMenu == 'home'
            ? HomePage()
            : selectedMenu == 'agenda'
            ? AgendaPage()
            : selectedMenu == 'contactos'
            ? ContactosPage()
            : selectedMenu == 'feedback'
            ? FeedbackPage()
            : selectedMenu == 'mapa'
            ? MapaPage()
            : selectedMenu == 'perfil'
            ? PerfilPage()
            : Text(selectedMenu));
  }

  addicionarMatriculaVan() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogPesquisaVan();
    });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", null);
    await prefs.setString("id", null);
    BackgroundLocation.stopLocationService();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  Widget menuHeader(PerfilModel perfil){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(color: Colors.black38))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: perfil != null ?
                    NetworkImage("${Constantes.BASE_URL_IMAGE}${perfil.funcionario.imagem}",) :
                    AssetImage(
                      "assets/images/amarildo.png",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  perfil != null ?
                  Text(perfil.funcionario.nome,
                    style: TextStyle(color: colorText, fontSize: 18),
                  ):
                  Text("Amarildo Ferreira",
                    style: TextStyle(color: colorText, fontSize: 18),
                  ),
                ]),
            onTap: () {
              print("Ver Perfil");
            },
          ),
          IconButton(
            icon: Icon(SimpleLineIcons.getIconData("close"),
                color: colorText, size: 28),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildMenu(PerfilModel perfil){
    return Container(
      height: MediaQuery.of(context).size.height - 93,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                "HOME",
                style: TextStyle(fontSize: 28),
              )),
            ),
            onTap: () {
              setState(() {
                selectedMenu = 'home';
                backgroudType = 'padrao';
              });
              Navigator.pop(context);
            },
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                "AGENDA",
                style: TextStyle(fontSize: 28),
              )),
            ),
            onTap: () {
              setState(() {
                selectedMenu = 'agenda';
                backgroudType = 'inverso';
              });
              Navigator.pop(context);
            },
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                "CONTACTOS",
                style: TextStyle(fontSize: 28),
              )),
            ),
            onTap: () {
              setState(() {
                selectedMenu = 'contactos';
                backgroudType = 'padrao';
              });
              Navigator.pop(context);
            },
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                "MAPA",
                style: TextStyle(fontSize: 28),
              )),
            ),
            onTap: () {
              setState(() {
                selectedMenu = 'mapa';
                backgroudType = 'padrao';
              });
              Navigator.pop(context);
            },
          ),
          perfil != null && perfil.roles.any((x) => x.name=="Motorista") ? InkWell(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                "ADICIONAR VAN",
                style: TextStyle(fontSize: 28),
              )),
            ),
            onTap: () {
              print("Adicionar a Van");
              addicionarMatriculaVan();
            },
          ): SizedBox(),
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                "MEU PERFIL",
                style: TextStyle(fontSize: 28),
              )),
            ),
            onTap: () {
              setState(() {
                selectedMenu = 'perfil';
                backgroudType = 'padrao';
              });
              Navigator.pop(context);
            },
          ),
          InkWell(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Icon(
                      SimpleLineIcons.getIconData('logout'))),
            ),
            onTap: () async{
              print("Terminar");
              await logout();
            },
          ),
        ],
      ),
    );
                
  }

}
