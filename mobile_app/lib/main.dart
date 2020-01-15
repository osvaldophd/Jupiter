import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:mobile_app/bloc/blocs.dart';
import 'package:mobile_app/ui/login_page.dart';
import 'package:mobile_app/ui/menu_container_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  SharedPreferences prefs;
  String token;
  StreamController<SharedPreferences> _prefControler =
      StreamController<SharedPreferences>.broadcast();
  Stream<SharedPreferences> get outPref => _prefControler.stream;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      _prefControler.sink.add(value);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _prefControler.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => WeatherBloc()),
        Bloc((i) => AuthBloc()),
        Bloc((i) => VanBloc()),
        Bloc((i) => EscalaDiaBloc()),
        Bloc((i) => FuncionarioBloc()),
        Bloc((i) => EscalaFuncionarioBloc()),
      ],
      child: MaterialApp(
          title: 'Boleia',
          theme: ThemeData(
              primaryColor: colorPrimary,
              accentColor: colorPrimaryAccent,
              backgroundColor: colorBackground,
              textTheme: TextTheme(
                headline: TextStyle(
                    fontSize: 72.0,
                    fontWeight: FontWeight.bold,
                    color: colorText),
                title: TextStyle(
                    fontSize: 36.0,
                    fontStyle: FontStyle.italic,
                    color: colorText),
                body1: TextStyle(
                    fontSize: 14.0, fontFamily: 'Montserrat', color: colorText),
              ),
              fontFamily: 'Montserrat',
              hintColor: colorBackground),
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<SharedPreferences>(
            stream: outPref,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                token = prefs.getString('token');
                if (token == null) {
                  return LoginPage();
                } else {
                  return MenuContainerPage();
                }
              } else {
                return Scaffold(
                  backgroundColor: colorBackground,
                  body: Center(
                    child: Image.asset("assets/images/logo.png",
                        height: MediaQuery.of(context).size.height * 0.2),
                  ),
                );
              }
            },
          ) //token == null ? : MenuContainerPage(),
          ),
    );
  }
}
