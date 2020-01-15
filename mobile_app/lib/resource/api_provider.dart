import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_app/util/constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_app/model/models.dart';

import 'package:http/io_client.dart';
import 'dart:io';

class ApiProvider {
  //Client client = Client();
  final ioc = new HttpClient();
  Client client;
  final _baseUrl = Constantes.BASE_URL_API;

  ApiProvider() {
    //client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    client = new IOClient(ioc);
  }

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  Future<WeatherForecast> weatherForecast() async {
    print("Weather 1");
    //try{
    final response = await Client().get(Constantes.WEATHER_FORECAST_URL);

    print("Weather 2: ${json.decode(response.body)}");

    if (response.statusCode == 200) {
      WeatherForecast model =
          WeatherForecast.fromJson(json.decode(response.body));
      model.exito = true;
      return model;
    } else {
      return WeatherForecast(
        exito: false,
        // message: json.decode(response.body)["message"],
        // cod: json.decode(response.body)["cod"],
      );
    }
    // } catch(Ex){
    //   return WeatherForecast(
    //     exito: false,
    //     //message: json.decode(response.body)["message"],
    //     //cod: json.decode(response.body)["cod"],
    //   );
    // }
  }

  Future<AuthModel> login(String email, String senha) async {
    Map<String, String> requestHeadersl = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    Map<String, String> data = {"email": email, "password": senha};

    //try{
    final response = await client.post("$_baseUrl/login",
        headers: requestHeadersl, body: data);
    print("login Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      AuthModel model = AuthModel.fromJson(json.decode(response.body));
      if (model.token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", model.token);
        // await prefs.setString("id", model.usuario.id.toString());
        // await prefs.setString("nome", model.usuario.name);
        print("Provider: " + model.token);
      }
      return model;
    } else {
      print(response.body);
      return AuthModel(
        status: false,
        // error: json.decode(response.body)["error"],
      );
    }
    // } catch(Ex){
    //   return AuthModel(
    //       status: false,
    //       // error: json.decode(response.body)["error"],
    //     );
    // }
  }

  Future<PerfilModel> getPerfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.length < 0) {
      return PerfilModel(
        status: false,
        //error: "Token vazio",
      );
    }
    Map<String, String> requestHeadersToken = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };

    final response =
        await client.post("$_baseUrl/me", headers: requestHeadersToken);
    print("getPerfil Response: ${response.statusCode}");

    if (response.statusCode == 200) {
      return PerfilModel.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      return PerfilModel(
        status: false,
        // error: json.decode(response.body)["error"],
      );
    }
  }

  Future<UpdateUserResponseModel> updatePerfil(UpdateUserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.length < 0) {
      return UpdateUserResponseModel(
        status: false,
      );
    }
    Map<String, String> requestHeadersl = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };
    var body = userModel.toJson();
    body.removeWhere((key, value) => value==null);
    // print(json.encode(userModel.imagem));
    final response = await client.put("$_baseUrl/funcionarios/${userModel.usuarioId}",
        headers: requestHeadersl, 
        body: json.encode(userModel)
      );
    print("updatePerfil Response: ${response.statusCode}");

    if (response.statusCode == 200) {
      UpdateUserResponseModel model = UpdateUserResponseModel
        .fromJson(json.decode(response.body));
      return model;
    } else if (response.statusCode == 201) {
      UpdateUserResponseModel model = UpdateUserResponseModel
        .fromJson(json.decode(response.body));
      return model;
    } else {
      print(response.body);
      return UpdateUserResponseModel(
        status: false,
      );
    }
  }

  Future<VanModel> getVans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.length < 0) {
      return VanModel(
        status: false,
        //error: "Token vazio",
      );
    }
    Map<String, String> requestHeadersToken = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };
    final response =
        await client.get("$_baseUrl/vans", headers: requestHeadersToken);
    //print("Response: ${json.decode(response.body)["matricula"]}");
    if (response.statusCode == 200) {
      return VanModel.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      return VanModel(
        status: false,
        // error: json.decode(response.body)["error"],
      );
    }
  }

  Future<VanMatriculaModel> getVanMatricula(String matricula) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.length < 0) {
      return VanMatriculaModel(
        status: false,
        //error: "Token vazio",
      );
    }
    Map<String, String> requestHeadersToken = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };

    final response = await client.get("$_baseUrl/vans/matricula/$matricula",
        headers: requestHeadersToken);
    print("getVanMatricula Response: ${response.statusCode}");

    if (response.statusCode == 200) {
      return VanMatriculaModel.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      return VanMatriculaModel(
        status: false,
        // error: json.decode(response.body)["error"],
      );
    }
  }

  Future<EscalaDiaModel> getEscalaHoje() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.length < 0) {
      return EscalaDiaModel(
        status: false,
        error: "Token vazio",
      );
    }
    Map<String, String> requestHeadersToken = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };
    final response = await client.get(
        "$_baseUrl/funcionarios-escalas/escala/dia",
        headers: requestHeadersToken);
    print("getEscalaHoje Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      return EscalaDiaModel.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      return EscalaDiaModel(
        status: false,
        // error: json.decode(response.body)["error"],
      );
    }
  }

  Future<EscalaDiaModel> getEscalaDia(int dia) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.length < 0) {
      return EscalaDiaModel(
        status: false,
        error: "Token vazio",
      );
    }
    Map<String, String> requestHeadersToken = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };
    final response = await client.get(
        "$_baseUrl/funcionarios-escalas/escala/dia/$dia",
        headers: requestHeadersToken);
    print("getEscalaDia Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      return EscalaDiaModel.fromJson(json.decode(response.body));
    } else {
      return EscalaDiaModel(
        status: false,
        // error: json.decode(response.body)["error"],
      );
    }
  }

  Future<FuncionarioModel> getFuncionarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.length < 0) {
      return FuncionarioModel(
        status: false,
        error: "Token vazio",
      );
    }
    Map<String, String> requestHeadersToken = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };
    final response = await client.get("$_baseUrl/funcionarios",
        headers: requestHeadersToken);
    print("getFuncionarios Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      return FuncionarioModel.fromJson(json.decode(response.body));
    } else {
      return FuncionarioModel(
        status: false,
        // error: json.decode(response.body)["error"],
      );
    }
  }

  Future<EscalaFuncionarioModel> getEscalaFuncionarios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    if (token == null || token.length < 0) {
      return EscalaFuncionarioModel(
        status: false,
        error: "Token vazio",
      );
    }
    Map<String, String> requestHeadersToken = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };
    final response = await client.get("$_baseUrl/funcionarios-escalas",
        headers: requestHeadersToken);
    print("getEscalaFuncionarios Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      return EscalaFuncionarioModel.fromJson(json.decode(response.body));
    } else {
      return EscalaFuncionarioModel(
        status: false,
        // error: json.decode(response.body)["error"],
      );
    }
  }
}
