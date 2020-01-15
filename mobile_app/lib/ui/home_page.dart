import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:background_location/background_location.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:mobile_app/model/escala_dia_model.dart';
import 'package:mobile_app/model/models.dart';
import 'package:mobile_app/model/van_model.dart';
import 'package:mobile_app/model/weather_forecast.dart';
import 'package:mobile_app/ui/widgets/dialog_call_van.dart';
import 'package:mobile_app/ui/widgets/dialog_menu_motorista.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_app/util/firebase_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final WeatherBloc _weatherBloc = BlocProvider.getBloc<WeatherBloc>();
  final VanBloc _vanBloc = BlocProvider.getBloc<VanBloc>();
  final EscalaDiaBloc _escalaDiaBloc = BlocProvider.getBloc<EscalaDiaBloc>();
  final FuncionarioBloc _funcionarioDiaBloc = BlocProvider.getBloc<FuncionarioBloc>();
  final AuthBloc _authBloc = BlocProvider.getBloc<AuthBloc>();
  DateTime today = DateTime.now();
  FirebaseUtil firebaseUtil = FirebaseUtil();

  String latitude = "waiting...";
  String longitude = "waiting...";

  @override
  void initState() {
    super.initState();
    // _weatherBloc.getWeatherForecast();
    _authBloc.getPerfils();
    _vanBloc.getVans();
    _escalaDiaBloc.getEscalaHoje();
    _funcionarioDiaBloc.getFuncionarios();
    BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates((location) {
      FirebaseUtil().addLocation(location.latitude, location.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[

      //------------------------------Wheather Content--------------------------
          Container(
            color: colorPrimary,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<WeatherForecast>(
              stream: _weatherBloc.outWForecast,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data.exito) return buildWeather(snapshot.data);
                  else return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: InkWell(
                        child: Text("Falha na conexão com a API de Tempo. Clique para tentar novamente 1", textAlign: TextAlign.center,),
                        onTap: () => print("Aqui $latitude"),
                        //onTap: () => _weatherBloc.getWeatherForecast(),
                      ),
                    ),
                  );
                } else if(_weatherBloc.downloadedWeather != null){
                  if(_weatherBloc.downloadedWeather.exito) return buildWeather(_weatherBloc.downloadedWeather);
                  else return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: InkWell(
                        child: Text("Falha na conexão com a API de Tempo. Clique para tentar novamente 2", textAlign: TextAlign.center,),
                        onTap: () => print("Aqui $latitude"),
                        //onTap: () => _weatherBloc.getWeatherForecast(),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: CircularProgressIndicator()),
                  );
                }
            }
          ),
        ),

      //------------------------------Escala List Header--------------------------
          Container(
            color: colorPrimary,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: colorBackground,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
              ),
              child: Column(
                children: <Widget>[

                  SizedBox(height: 30,),

                  Center(
                    child: InkWell(
                      child: Text(
                        "Escala do dia",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      
                        onTap: () {
                          
                      },
                    ),
                  ),

                  SizedBox(height: 10,),

                  Center(
                    child: InkWell(
                      child: Text("Luanda, ${Constantes.dataFormato1(DateTime.now())}"),
                      onTap: () => BackgroundLocation.stopLocationService(),
                    ),
                  ),

                ],
              ),    
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10,),
            child: Text("MOTORISTAS"),
          ),

      //------------------------------Escala List Content--------------------------
          StreamBuilder<EscalaDiaModel>(
            stream: _escalaDiaBloc.outEscalaHoje,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return buildEscalaDiaList(snapshot.data);
              } else if(_escalaDiaBloc.previousEscalaHoje != null){
                return buildEscalaDiaList(_escalaDiaBloc.previousEscalaHoje);
              } else {
                return Center(child: CircularProgressIndicator(),);
              }
              
            }
          ),

      //------------------------------Escala Vans Content--------------------------
          SizedBox(height: 50.0,),
          Container(
            height: 210,
            child: StreamBuilder<VanModel>(
              stream: _vanBloc.outVan,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return buildVansList(snapshot.data);
                } else if(_vanBloc.previousVans != null){
                  return buildVansList(_vanBloc.previousVans);
                } else{
                  return Center(child: CircularProgressIndicator(),);
                }
              }
            ),
          ),
                  
          //------------------------------Escala Plantao Content--------------------------
    
              SizedBox(height: 20.0,),
              InkWell(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: 30,),
                      Text("PLANTÃO (Sextas e Sábados)".toUpperCase(), style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("992 516 218", style: TextStyle(fontSize: 18),),
                          Text("941 211 150", style: TextStyle(fontSize: 18),)
                        ],
                      ),
    
                      SizedBox(height: 10,),
    
                      Icon(SimpleLineIcons.getIconData("phone"), color: colorPrimaryAccent,),
    
                      SizedBox(height: 30,),
    
                    ], 
                  ),
                ), 
                onTap: ()  {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogMenuMotorista(
                        [
                          ContactoFuncionario(contacto: "992 516 218"),
                          ContactoFuncionario(contacto: "941 211 150"),
                        ]
                      );
                  });
                },
              ),
    
              SizedBox(height: 10,),
    
            ],          
        );
  }
    
  Widget buildWeather(WeatherForecast weatherForecast){
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
    
              //Text("O TEMPO HOJE", style: TextStyle(fontWeight: FontWeight.w600),),
              SizedBox(height: 5,),
              Container(
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
    
                    Column(
                      children: <Widget>[
                        Image.network(
                          Constantes.iconUrlWeather(weatherForecast.list[0].weather[0].icon),
                          width: MediaQuery.of(context).size.width*0.2,
                        ),
                        Text("${weatherForecast.list[0].dtTxt.hour}h:${weatherForecast.list[0].dtTxt.minute}m"),
                        Text(weatherForecast.list[0].main.temp.toString()),
                      ],
                    ),
    
                    Column(
                      children: <Widget>[
                        Icon(Icons.cloud, size: MediaQuery.of(context).size.width*0.2, color: colorBackground,),
                        Text("15:00"),
                        Text("30 C"),
                      ],
                    ),
                    
                    Column(
                      children: <Widget>[
                        Icon(Icons.cloud, size: MediaQuery.of(context).size.width*0.2, color: colorBackground,),
                        Text("18:00"),
                        Text("30 C"),
                      ],
                    ),
    
                    Column(
                      children: <Widget>[
                        Icon(Icons.cloud, size: MediaQuery.of(context).size.width*0.2, color: colorBackground,),
                        Text("21:00"),
                        Text("30 C"),
                      ],
                    ),
                  
                  ],
                ),
              ),
    
              SizedBox(height: 30,),
    
              //Text("O TEMPO NOS PROXIMOS 5 DIAS", style: TextStyle(fontWeight: FontWeight.w600),),
              SizedBox(height: 5,),
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
    
                    Column(
                      children: <Widget>[
                        Text("QUI"),
                        Icon(Icons.cloud, size: MediaQuery.of(context).size.width*0.1, color: colorBackground,),
                        Text("30 C"),
                      ],
                    ),
    
                    Column(
                      children: <Widget>[
                        Text("SEX"),
                        Icon(Icons.cloud, size: MediaQuery.of(context).size.width*0.1, color: colorBackground,),
                        Text("30 C"),
                      ],
                    ),
                    
                    Column(
                      children: <Widget>[
                        Text("SAB"),
                        Icon(Icons.cloud, size: MediaQuery.of(context).size.width*0.1, color: colorBackground,),
                        Text("30 C"),
                      ],
                    ),
    
                    Column(
                      children: <Widget>[
                        Text("DOM"),
                        Icon(Icons.cloud, size: MediaQuery.of(context).size.width*0.1, color: colorBackground,),
                        Text("30 C"),
                      ],
                    ),
    
                    Column(
                      children: <Widget>[
                        Text("SEG"),
                        Icon(Icons.cloud, size: MediaQuery.of(context).size.width*0.1, color: colorBackground,),
                        Text("30 C"),
                      ],
                    ),
                  
                  ],
                ),
              )
    
            ],
        );
      }
    
  Widget buildEscalaDiaList(EscalaDiaModel escalaDiaModel){
      List<FuncionarioEscala> listaEscala = escalaDiaModel.data.funcionarioEscala;
      return ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listaEscala.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index)  {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            leading: CircleAvatar(
              backgroundImage: NetworkImage("${Constantes.BASE_URL_IMAGE}${listaEscala[index].funcionario.imagem}", 
            ),
            ),
            trailing: IconButton(
              icon: Icon(SimpleLineIcons.getIconData("star")),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      //contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(SimpleLineIcons.getIconData("star")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(SimpleLineIcons.getIconData("star")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(SimpleLineIcons.getIconData("star")),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(SimpleLineIcons.getIconData("star")),
                            ),
                            
                          ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Votar"),
                          onPressed: () {},
                        )
                      ],
                    );
                  }
                );
              },
            ),
            title: Text(
              listaEscala[index].funcionario.nome, 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text("Nacionalidade: ${listaEscala[index].funcionario.nacionalidade}\nGenero:${listaEscala[index].funcionario.genero == 'M' ? 'Masculino' : 'Feminino'}"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogMenuMotorista(listaEscala[index].funcionario.contactos);
              });
            },
          );
        },
      );
    }

  Widget buildVansList(VanModel vans) {
      List<Van> listaVans = vans.data.vans;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listaVans.length,
        itemBuilder: (context, index)  {
          return Card(
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width*0.4,
                height: 210,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[

                    Image.network(
                      "${Constantes.BASE_URL_IMAGE}${listaVans[index].imagem}",
                      height: 128,
                      fit: BoxFit.contain,
                    ), 

                    Text(
                      listaVans[index].matricula, 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    //SizedBox(height: 10,),
                    //Text("917 685 929 | 917 685 930"),
                    SizedBox(height: 10,),
                    Icon(SimpleLineIcons.getIconData("phone"), color: colorPrimaryAccent,),
                  ],
                ),
              ),
              onTap: () {
                if(listaVans[index].contactos != null){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogCallVan(listaVans[index].contactos);
                    });
                  // dialogChamada(listaVans[index].contactos);
                }
              },
            ),
          );
          
        },
      );
                
    }

}